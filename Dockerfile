FROM mobiledevops/android-sdk-image:33.0.2

ENV FLUTTER_VERSION="3.10.3"
ENV DART_VERSION="3.2.0"
ENV FLUTTER_HOME "/home/mobiledevops/.flutter-sdk"
ENV PATH $PATH:$FLUTTER_HOME/bin

# Download and extract Flutter SDK
RUN mkdir $FLUTTER_HOME \
    && cd $FLUTTER_HOME \
    && curl --fail --remote-time --silent --location -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz --strip-components=1 \
    && rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

# Download and extract Dart SDK
RUN cd $FLUTTER_HOME \
    && curl --fail --remote-time --silent --location -O https://storage.googleapis.com/dart-archive/channels/stable/release/{DART_VERSION}/sdk/dartsdk-macos-arm64-release.zip \
    && unzip dartsdk-linux-arm64-release.zip \
    && rm dartsdk-linux-arm64-release.zip

# Set Dart SDK path
ENV PATH $PATH:$FLUTTER_HOME/bin:$FLUTTER_HOME/cache/dart-sdk/bin

RUN flutter precache
