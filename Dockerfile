FROM mobiledevops/android-sdk-image:33.0.2

ENV FLUTTER_VERSION="2.10.3"
ENV DART_VERSION="3.2.0"
ENV FLUTTER_HOME "/home/mobiledevops/.flutter-sdk"
ENV PATH $PATH:$FLUTTER_HOME/bin

# Download and extract Flutter SDK
RUN mkdir $FLUTTER_HOME \
    && cd $FLUTTER_HOME \
    && curl --fail --remote-time --silent --location -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz --strip-components=1 \
    && rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

# Install specific Dart SDK version
RUN cd $FLUTTER_HOME \
    && curl --fail --remote-time --silent --location -O https://dart-sdk.dev/flutter/sdk/releases/download/${DART_VERSION}/dart-sdk-linux-x64-release.zip \
    && unzip dart-sdk-linux-x64-release.zip \
    && rm dart-sdk-linux-x64-release.zip

# Set the Dart SDK path in the Flutter environment
ENV PATH $PATH:$FLUTTER_HOME/bin/cache/dart-sdk/bin

RUN flutter precache
