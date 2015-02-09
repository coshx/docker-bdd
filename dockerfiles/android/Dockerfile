FROM jacekmarchwicki/android:java7
CMD ["/bin/bash"]

RUN cd /opt; wget https://services.gradle.org/distributions/gradle-2.2.1-bin.zip; unzip -o gradle-2.2.1-bin.zip

WORKDIR /app
# problem: If i do ./gradlew assembleRelease, I still wind up downloading the latest version of gradle, so it's a little redundant and takes a while... (Gradle 1.9 doesn't do the job and I don't know how to just use it to DO the job..)

