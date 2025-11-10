#!/bin/bash
CURRENT_DISTRIBUTION="$(java -version 2>&1 | tr '[:upper:]' '[:lower:]' | grep -Eo 'corretto|temurin|zulu|openjdk' | head -n1 || echo "unknown")"
CURRENT_JAVA_VER="$(java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1)"
CURRENT_JAVAC_VER="$(javac -version 2>&1 | head -1 | cut -f 2- -d ' ' | sed '/^1\./s///' | cut -d'.' -f1)"
echo "Current Java Version: $CURRENT_JAVA_VER"
echo "Current Java Compiler Version : $CURRENT_JAVAC_VER"
if [ "$CURRENT_JAVA_VER" -ne "${PARAM_JAVA_VER}" ] && [ "$CURRENT_DISTRIBUTION" != "${PARAM_DISTRIBUTION}" ]; then
  if [ "${PARAM_DISTRIBUTION}" = "openjdk" ]; then
    if [ "${PARAM_JAVA_VER}" -eq 8 ] || [ "${PARAM_JAVA_VER}" -eq 17 ]; then
      if [ "${PARAM_JAVA_VER}" -eq 8 ]; then
        sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
      else
        sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
      fi
      sudo update-alternatives --set javac /usr/lib/jvm/java-"${PARAM_JAVA_VER}"-openjdk-amd64/bin/javac
    else
      sudo apt-get update
      sudo apt install openjdk-"${PARAM_JAVA_VER}"-jdk
      sudo update-alternatives --set javac /usr/lib/jvm/java-"${PARAM_JAVA_VER}"-openjdk-amd64/bin/javac
      sudo update-alternatives --set java /usr/lib/jvm/java-"${PARAM_JAVA_VER}"-openjdk-amd64/bin/java
    fi
    echo "export JAVA_HOME=/usr/lib/jvm/java-${PARAM_JAVA_VER}-openjdk-amd64" >> "$BASH_ENV"
  else 
    case "${PARAM_DISTRIBUTION}" in
      "corretto")
        sudo apt update
        sudo apt install wget gnupg
        wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add -
        sudo add-apt-repository 'deb https://apt.corretto.aws stable main'
        sudo apt update
        sudo apt install java-"${PARAM_JAVA_VER}"-amazon-corretto-jdk
        sudo update-alternatives --set javac /usr/lib/jvm/java-"${PARAM_JAVA_VER}"-amazon-corretto/bin/javac
        sudo update-alternatives --set java /usr/lib/jvm/java-"${PARAM_JAVA_VER}"-amazon-corretto/bin/java
        echo "export JAVA_HOME=/usr/lib/jvm/java-${PARAM_JAVA_VER}-amazon-corretto" >> "$BASH_ENV"
        ;;
      "temurin")
        sudo apt update
        sudo apt install wget apt-transport-https gpg
        wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /usr/share/keyrings/adoptium.gpg
        echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
        sudo apt update
        sudo apt install temurin-"${PARAM_JAVA_VER}"-jdk
        sudo update-alternatives --set javac /usr/lib/jvm/temurin-"${PARAM_JAVA_VER}"-jdk-amd64/bin/javac
        sudo update-alternatives --set java /usr/lib/jvm/temurin-"${PARAM_JAVA_VER}"-jdk-amd64/bin/java
        echo "export JAVA_HOME=/usr/lib/jvm/temurin-${PARAM_JAVA_VER}-jdk-amd64" >> "$BASH_ENV"
        ;;
      "zulu")
        sudo apt update
        sudo apt install gnupg software-properties-common
        wget -qO - https://repos.azul.com/azul-repo.key | sudo apt-key add -
        sudo apt-add-repository 'deb http://repos.azul.com/zulu/deb stable main'
        sudo apt update
        sudo apt install zulu"${PARAM_JAVA_VER}"-jdk
        sudo update-alternatives --set javac /usr/lib/jvm/zulu-"${PARAM_JAVA_VER}"-amd64/bin/javac
        sudo update-alternatives --set java /usr/lib/jvm/zulu-"${PARAM_JAVA_VER}"-amd64/bin/java
        echo "export JAVA_HOME=/usr/lib/jvm/zulu-${PARAM_JAVA_VER}-amd64" >> "$BASH_ENV"
        ;;
      *)
        echo "Unknown distribution: ${PARAM_DISTRIBUTION}"
        return 1
        ;;
    esac
  fi
  echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> "$BASH_ENV"
fi
NEW_JAVA_VER="$(java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1)"
NEW_JAVAC_VER="$(javac -version 2>&1 | head -1 | cut -f 2- -d ' ' | sed '/^1\./s///' | cut -d'.' -f1)"
echo "New Java Version : $NEW_JAVA_VER"
echo "New Java Compiler Version : $NEW_JAVAC_VER"
