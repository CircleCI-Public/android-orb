#!/bin/bash
 CURRENT_JAVA_VER="$( java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1 )"
        CURRENT_JAVAC_VER="$( javac -version 2>&1 | head -1 | cut -f 2- -d ' ' | sed '/^1\./s///' | cut -d'.' -f1 )"
        echo "Current Java Version: $CURRENT_JAVA_VER"
        echo "Current Java Compiler Version : $CURRENT_JAVAC_VER"
        if [ "$CURRENT_JAVA_VER" -ne "${PARAM_JAVA_VER}" ]; then
          if [ "${PARAM_JAVA_VER}" -eq 8 ] || [ "${PARAM_JAVA_VER}" -eq 17 ]; then
            if [ "${PARAM_JAVA_VER}" -eq 8 ]; then
              sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
            else
              sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
            fi
            sudo update-alternatives --set javac /usr/lib/jvm/java-"${PARAM_JAVA_VER}"-openjdk-amd64/bin/javac
          else
            sudo apt install openjdk-"${PARAM_JAVA_VER}"-jdk
            sudo update-alternatives --set javac /usr/lib/jvm/java-"${PARAM_JAVA_VER}"-openjdk-amd64/bin/javac
            sudo update-alternatives --set java /usr/lib/jvm/java-"${PARAM_JAVA_VER}"-openjdk-amd64/bin/java
          fi
          echo "export JAVA_HOME=/usr/lib/jvm/java-${PARAM_JAVA_VER}-openjdk-amd64" >> ~/.bashrc
          echo "export PATH=$JAVA_HOME/bin:$PATH" >> ~/.bashrc
        fi
        NEW_JAVA_VER="$( java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1 )"
        NEW_JAVAC_VER="$( javac -version 2>&1 | head -1 | cut -f 2- -d ' ' | sed '/^1\./s///' | cut -d'.' -f1 )"
        echo "New Java Version : $NEW_JAVA_VER"
        echo "New Java Compiler Version : $NEW_JAVAC_VER"