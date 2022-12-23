dencode-web
============================
DenCode is a web application for encoding and decoding values.  
e.g. HTML Escape / URL Encoding / Base64 / MD5 / SHA-1 / CRC32 / and many other String, Number, DateTime, Color, Cipher, Hash formats

## Website
[https://dencode.com/](https://dencode.com/)

## Usage
Install [Java SE Development Kit (JDK)](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and [Google Cloud SDK](https://cloud.google.com/sdk/).

Open a shell or command line and execute the following commands on the project root directory.

Run on local machine:

```console
./gradlew appRunStage
```

Deploy to Google App Engine:

```console
gcloud config set project {PROJECT_ID}
./gradlew appengineDeploy
```

(Please replace {PROJECT_ID} to your own project id.)

## Supported encoding
- [String](https://dencode.com/string)
    - [Bin String](https://dencode.com/string/bin)
    - [Hex String](https://dencode.com/string/hex)
    - [HTML Escape](https://dencode.com/string/html-escape)
    - [URL Encoding](https://dencode.com/string/url-encoding)
    - [Punycode IDN](https://dencode.com/string/punycode)
    - [Base32](https://dencode.com/string/base32)
    - [Base45](https://dencode.com/string/base45)
    - [Base64](https://dencode.com/string/base64)
    - [Ascii85](https://dencode.com/string/ascii85)
    - [Quoted-printable](https://dencode.com/string/quoted-printable)
    - [Unicode Escape](https://dencode.com/string/unicode-escape)
    - [Program String](https://dencode.com/string/program-string)
    - [Morse Code](https://dencode.com/string/morse-code)
    - [Naming Convention](https://dencode.com/string/naming-convention)
        - [Camel Case](https://dencode.com/string/camel-case)
        - [Snake Case](https://dencode.com/string/snake-case)
        - [Kebab Case](https://dencode.com/string/kebab-case)
    - [Character Width (Half, Full)](https://dencode.com/string/character-width)
    - [Letter Case (Upper, Lower, Swap, Capital)](https://dencode.com/string/letter-case)
    - [Text Initials](https://dencode.com/string/text-initials)
    - [Text Reverse](https://dencode.com/string/text-reverse)
    - [Unicode Normalization](https://dencode.com/string/unicode-normalization)
    - [Line Sort](https://dencode.com/string/line-sort)
    - [Line Unique](https://dencode.com/string/line-unique)
- [Number](https://dencode.com/number)
    - [Decimal Numbers](https://dencode.com/number/dec)
    - [Binary Numbers](https://dencode.com/number/bin)
    - [Octal Numbers](https://dencode.com/number/oct)
    - [Hexadecimal Numbers](https://dencode.com/number/hex)
    - [English Numerals](https://dencode.com/number/english)
    - [Kanji Numerals](https://dencode.com/number/japanese)
- [Date](https://dencode.com/date)
    - [UNIX Time](https://dencode.com/date/unix-time)
    - [W3C-DTF Date](https://dencode.com/date/w3cdtf)
    - [ISO8601 Date](https://dencode.com/date/iso8601)
    - [RFC2822 Date](https://dencode.com/date/rfc2822)
    - [CTime Date](https://dencode.com/date/ctime)
    - [Japanese Era](https://dencode.com/date/japanese-era)
- [Color](https://dencode.com/color)
    - [Color Name](https://dencode.com/color/name)
    - [RGB Color](https://dencode.com/color/rgb)
    - [HSL Color](https://dencode.com/color/hsl)
    - [HSV Color](https://dencode.com/color/hsv)
    - [CMYK Color](https://dencode.com/color/cmyk)
- [Cipher](https://dencode.com/cipher)
    - [Caesar Cipher](https://dencode.com/cipher/caesar)
    - [ROT13](https://dencode.com/cipher/rot13)
    - [ROT18](https://dencode.com/cipher/rot18)
    - [ROT47](https://dencode.com/cipher/rot47)
    - [Atbash Cipher](https://dencode.com/cipher/atbash)
    - [Enigma Cipher](https://dencode.com/cipher/enigma)
    - [JIS Keyboard](https://dencode.com/cipher/jis-keyboard)
    - [Scytale Cipher](https://dencode.com/cipher/scytale)
    - [Rail Fence Cipher](https://dencode.com/cipher/rail-fence)
- [Hash](https://dencode.com/hash)
    - [MD2](https://dencode.com/hash/md2)
    - [MD5](https://dencode.com/hash/md5)
    - [SHA-1](https://dencode.com/hash/sha1)
    - [SHA-256](https://dencode.com/hash/sha256)
    - [SHA-384](https://dencode.com/hash/sha384)
    - [SHA-512](https://dencode.com/hash/sha512)
    - [CRC32](https://dencode.com/hash/crc32)

## I18n support
DenCode supports English (en), Japanese (ja) and Russian (ru).
If you want to add other languages, please add or modify the following source code.

- Append a new language-code to locales config with comma separator (like locales=en,ja,ru)
    - /src/main/resources/config.properties [Required]
- Add translated files
    - /src/main/resources/messages_*.properties [Required]
    - /src/main/webapp/WEB-INF/pages/policy_*.inc.jsp [Optional]
    - /src/main/webapp/WEB-INF/pages/method-desc_*.*_*.inc.jsp [Optional]

## How to add another encoder and decoder
If you want to add another encoder and decoder, please add or modify the following source code.

- Add a new dencoder class
    - /src/main/java/com/dencode/logic/dencoder/*.java [Required]
- Append new settings for the dencoder
    - /src/main/resources/config.properties [Required]
- Append the encoding and decoding rows for the dencoder
    - /src/main/webapp/WEB-INF/pages/index.jsp [Required]
- Append label texts for index.jsp
    - /src/main/resources/messages_*.properties [Required]
- Add description files
    - /src/main/webapp/WEB-INF/pages/method-desc_*.*_*.inc.jsp [Optional]
