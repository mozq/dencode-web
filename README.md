dencode-web
============================
DenCode is a web application for encoding and decoding values.  
e.g. HTML Escape / URL Encoding / Base64 / MD5 / SHA-1 / CRC32 / and many other String, Number, DateTime, Color, Hash formats

## Website
[https://dencode.com/](https://dencode.com/)

## Usage
Install [Java SE Development Kit (JDK)](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and [Google Cloud SDK](https://cloud.google.com/sdk/).

Open shell or command line and execute following commands on the project root directory.

Run on local machine:

```
./gradlew appRunStage
```

Deploy to Google App Engine:

```
gcloud config set project {PROJECT_ID}
./gradlew appengineDeploy
```

(Please replace {PROJECT_ID} to your own project id.)
