FROM wasabeef/android
CMD ["/bin/bash"]

# Update Android SDK
# This checks for all SDK available downloads. -u (or "--no-ui") and lists
# results on console (no GUI), -e (or "--extended") displays extended deatils
# on each package.
RUN android list sdk -u -e | grep build-tools- | perl -npe 's/.+"(.+)"/$1/' > /tmp/build-tools-version
RUN perl -e 'die "No Android build tools version found." unless -s "/tmp/build-tools-version"'
RUN echo y | android update sdk -u -t $(cat /tmp/build-tools-version)
RUN echo y | android update sdk -u -t android-17

# Gets appcompat, which seems to be a dependancy
RUN echo y | android update sdk --no-ui --filter extra-android-support --all

# Updates Environment Variables
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANT_HOME /usr/local/apache-ant-1.9.2
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANT_HOME/bin
ENV IN_DOCKER 1

# Install base tools
RUN yum install -y zsh git vim && yum clean all

# problem: If i do ./gradlew assembleRelease, I still wind up downloading the latest version of gradle, so it's a little redundant and takes a while... (Gradle 1.9 doesn't do the job and I don't know how to just use it to DO the job..)