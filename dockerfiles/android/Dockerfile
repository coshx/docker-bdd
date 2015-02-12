FROM jacekmarchwicki/android:java7
CMD ["/bin/bash"]

# gradlew downloading causes strange results in cucumber in CI and on Ben's computer
# so I use gradle instead
RUN cd /opt; wget https://services.gradle.org/distributions/gradle-2.2.1-bin.zip; unzip -o gradle-2.2.1-bin.zip

WORKDIR /app
