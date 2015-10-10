
require 'httparty'
require 'json'
require 'base64'

module DSP
  autoload :API , 'dsp/api'
  autoload :BID , 'dsp/bid'

  VERSION='0.0.3'

  AUTH = {dsp_id: 190, token: '73553e669b7270a4934706f76a99ad36'}
  ADX_URL = 'http://opentest.adx.qq.com'

  class TEA
    ROUND = 16
    LOG_ROUNDS = 4
    DELTA = 0x9e3779b9
    SALT_LEN = 2
    ZERO_LEN = 7
    class << self
      def decrypt(encryptContent, key)
        con = convertByteToInt(encryptContent)
        k = convertByteToInt(key)
        y = getUnsignedInt(con[0])
        z = getUnsignedInt(con[1])
        sum = 0
        a = k[0]
        b = k[1]
        c = k[2]
        d = k[3]
        sum = getUnsignedInt(0x9e3779b9 << LOG_ROUNDS)
        delta = getUnsignedInt(0x9e3779b9)
        for i in (0...ROUND)
          z -= (y << 4) + c ^ y + sum ^ (y >> 5) + d
          z &= 0xffffffff
          y -= (z << 4) + a ^ z + sum ^ (z >> 5) + b
          y &= 0xffffffff
          sum -= delta
          sum &= 0xffffffff
        end

        con[0] = y | 0x0
        con[1] = z | 0x0
        return convertIntToByte(con)
      end

      def getUnsignedInt(data)
        return data & 0xffffffff
      end

      def convertByteToInt(content)
        tmp = []
        result = []
        len = content.length
        raise "Invalid length of byte array, must be 4 times." if len % 4 != 0

        for i in 0...(len / 4)
          tmp[0,4] = content[i*4, 4]
          result[i] = ntohl(tmp)
        end

        return result
      end

      def convertIntToByte(content)
        result = []
        for i in (0...content.length)
          tmp = htonl(content[i])
          # System.arraycopy(tmp, 0, result, i * 4, 4)
          result[i*4, 4] = tmp[0, 4]
        end
        return result
      end

      def htonl(x)
        res = []
        for i in (0...4)
          res[i] = x >> 24 & 0xff
          x <<= 8
        end

        return res
      end

      def ntohl(x)
        res = 0
        for i in (0...4)
          res <<= 8
          res |= 0xff & x[i]
        end

        return res
      end

      def decryptData( pInBuf,  pKey)
        nBufPos = 0
        dest_buf = []
        zero_buf = []
        cur_buf = []
        nInBufLen = pInBuf.length
        return nil if nInBufLen % 8 != 0 || nInBufLen < 16 || pKey.length != 16
        cur_buf[0,8] = pInBuf[0,8]
        dest_buf = decrypt(cur_buf, pKey)
        nPadLen = dest_buf[0] & 7
        textLen = nInBufLen - 1 - nPadLen - 2 - 7
        pOutBufLen = textLen
        pOutBuf = []

        for i in (0...pOutBufLen)
          pOutBuf[i] = 48
        end

        for i in (0...8)
          zero_buf[i] = 0
        end

        iv_pre_crypt = zero_buf.clone
        iv_cur_crypt = cur_buf.clone
        nBufPos += 8
        cur_buf[0, 8] = pInBuf[8, 8]
        dest_i = 1
        dest_i += nPadLen

        i = 1
        while i <= 2
          if(dest_i < 8)
            dest_i += 1
            i += 1
          elsif(dest_i == 8)
            iv_pre_crypt = iv_cur_crypt.clone
            iv_cur_crypt = cur_buf.clone
            for j in (0...8)
              return nil if (nBufPos + j >= nInBufLen)
              dest_buf[j] ^= pInBuf[nBufPos + j]
            end
            dest_buf = decrypt(dest_buf, pKey)
            nBufPos += 8
            cur_buf[0, 8] = pInBuf[16, 8]
            dest_i = 0
          end
        end
        nPlainLen = pOutBufLen
        i = 0
        while nPlainLen > 0
          if(dest_i < 8)
            pOutBuf[i+=1] = dest_buf[dest_i] ^ iv_pre_crypt[dest_i]
            dest_i+=1
            nPlainLen-=1
          elsif(dest_i == 8)
            iv_pre_crypt = iv_cur_crypt.clone
            iv_cur_crypt = cur_buf.clone
            for j in (0...8)
              return nil if(nBufPos + j >= nInBufLen)
              dest_buf[j] ^= pInBuf[nBufPos + j]
            end
            dest_buf = decrypt(dest_buf, pKey)
            nBufPos += 8
            dest_i = 0
          end
        end
        i = 1
        while i <= 7
          if(dest_i < 8)
            if((dest_buf[dest_i] ^ iv_pre_crypt[dest_i]) != 1)
              dest_i+=1
              i+=1
            else
              return nil
            end
          elsif(dest_i == 8)
            iv_pre_crypt = iv_cur_crypt.clone
            iv_cur_crypt = cur_buf.clone
            for j in (0...8)
              return nil if(nBufPos + j >= nInBufLen)
              dest_buf[j] ^= pInBuf[j]
            end
            dest_buf = decrypt(dest_buf, pKey)
            nBufPos += 8
            dest_i = 0
          end
        end

        return pOutBuf
      end

      def decryptString(encryptedStr , key)
        infoStr = Base64.decode64(encryptedStr).bytes
        bKey = key.bytes
        res = decryptData(infoStr, bKey)
        res.pack('c*')
      end
    end
  end
end
