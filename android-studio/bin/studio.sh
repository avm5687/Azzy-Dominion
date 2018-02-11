#!/bin/sh
#
# ---------------------------------------------------------------------
# Android Studio startup script.
# ---------------------------------------------------------------------
#

message()
{
  TITLE="Cannot start Android Studio"
  if [ -n "`which zenity`" ]; then
    zenity --error --title="$TITLE" --text="$1"
  elif [ -n "`which kdialog`" ]; then
    kdialog --error "$1" --title "$TITLE"
  elif [ -n "`which xmessage`" ]; then
    xmessage -center "ERROR: $TITLE: $1"
  elif [ -n "`which notify-send`" ]; then
    notify-send "ERROR: $TITLE: $1"
  else
    echo "ERROR: $TITLE\n$1"
  fi
}

isJDK()
{
  if [ -z $1 ] || [ ! -x "$1/bin/java" ]; then
    return 1
  else
    return 0
  fi
}

UNAME=`which uname`
GREP=`which egrep`
GREP_OPTIONS=""
CUT=`which cut`
READLINK=`which readlink`
XARGS=`which xargs`
DIRNAME=`which dirname`
MKTEMP=`which mktemp`
RM=`which rm`
CAT=`which cat`
TR=`which tr`

if [ -z "$UNAME" -o -z "$GREP" -o -z "$CUT" -o -z "$MKTEMP" -o -z "$RM" -o -z "$CAT" -o -z "$TR" ]; then
  message "Required tools are missing - check beginning of \"$0\" file for details."
  exit 1
fi

OS_TYPE=`"$UNAME" -s`

# ---------------------------------------------------------------------
# Ensure IDE_HOME points to the directory where the IDE is installed.
# ---------------------------------------------------------------------
SCRIPT_LOCATION=$0
if [ -x "$READLINK" ]; then
  while [ -L "$SCRIPT_LOCATION" ]; do
    SCRIPT_LOCATION=`"$READLINK" -e "$SCRIPT_LOCATION"`
  done
fi

IDE_BIN_HOME=`dirname "$SCRIPT_LOCATION"`
if [ "$IDE_BIN_HOME" = "." ]; then
  IDE_HOME=".."
else
  IDE_HOME=`dirname "$IDE_BIN_HOME"`
fi

# ---------------------------------------------------------------------
# Locate a JDK installation directory which will be used to run the IDE.
# Try (in order): STUDIO_JDK, studio.jdk, ../jre, JDK_HOME, JAVA_HOME, "java" in PATH.
# ---------------------------------------------------------------------
JDK=""
if isJDK $STUDIO_JDK; then
  JDK="$STUDIO_JDK"
fi

if [ "$JDK" = "" ] && [ -s "$HOME/.AndroidStudio3.0/config/studio.jdk" ]; then
  JDK=`"$CAT" $HOME/.AndroidStudio3.0/config/studio.jdk`
  if [ ! -d "$JDK" ]; then
    JDK="$IDE_HOME/$JDK"
  fi
  if ! isJDK $JDK; then
    JDK=""
  fi
fi

if [ "$JDK" = "" ] && [ "$OS_TYPE" = "Linux" ] &&
   [ -x "$IDE_HOME/jre/bin/java" ] && "$IDE_HOME/jre/bin/java" -version > /dev/null 2>&1 ; then
  JDK="$IDE_HOME/jre"
fi

if [ "$JDK" = "" ] && isJDK $JDK_HOME; then
  JDK="$JDK_HOME"
fi

if [ "$JDK" = "" ]; then
  if isJDK $JAVA_HOME; then
    JDK="$JAVA_HOME"
  else
    JAVA_BIN_PATH=`which java`
    if [ -n "$JAVA_BIN_PATH" ]; then
      if [ "$OS_TYPE" = "FreeBSD" -o "$OS_TYPE" = "MidnightBSD" ]; then
        JAVA_LOCATION=`JAVAVM_DRYRUN=yes java | "$GREP" '^JAVA_HOME' | "$CUT" -c11-`
        if [ -x "$JAVA_LOCATION/bin/java" ]; then
          JDK="$JAVA_LOCATION"
        fi
      elif [ "$OS_TYPE" = "SunOS" ]; then
        JAVA_LOCATION="/usr/jdk/latest"
        if [ -x "$JAVA_LOCATION/bin/java" ]; then
          JDK="$JAVA_LOCATION"
        fi
      elif [ "$OS_TYPE" = "Darwin" ]; then
        JAVA_LOCATION=`/usr/libexec/java_home`
        if [ -x "$JAVA_LOCATION/bin/java" ]; then
          JDK="$JAVA_LOCATION"
        fi
      fi
    fi

    if [ -z "$JDK" -a -x "$READLINK" -a -x "$XARGS" -a -x "$DIRNAME" ]; then
      JAVA_LOCATION=`"$READLINK" -f "$JAVA_BIN_PATH"`
      case "$JAVA_LOCATION" in
        */jre/bin/java)
          JAVA_LOCATION=`echo "$JAVA_LOCATION" | "$XARGS" "$DIRNAME" | "$XARGS" "$DIRNAME" | "$XARGS" "$DIRNAME"`
          if [ ! -d "$JAVA_LOCATION/bin" ]; then
            JAVA_LOCATION="$JAVA_LOCATION/jre"
          fi
          ;;
        *)
          JAVA_LOCATION=`echo "$JAVA_LOCATION" | "$XARGS" "$DIRNAME" | "$XARGS" "$DIRNAME"`
          ;;
      esac
      if [ -x "$JAVA_LOCATION/bin/java" ]; then
        JDK="$JAVA_LOCATION"
      fi
    fi
  fi
fi

JAVA_BIN="$JDK/bin/java"
if [ ! -x "$JAVA_BIN" ]; then
  JAVA_BIN="$JDK/jre/bin/java"
fi

if [ -z "$JDK" ] || [ ! -x "$JAVA_BIN" ]; then
  message "No JDK found. Please validate either STUDIO_JDK, JDK_HOME or JAVA_HOME environment variable points to valid JDK installation."
  exit 1
fi

VERSION_LOG=`"$MKTEMP" -t java.version.log.XXXXXX`
JAVA_TOOL_OPTIONS= "$JAVA_BIN" -version 2> "$VERSION_LOG"
"$GREP" "64-Bit|x86_64|amd64" "$VERSION_LOG" > /dev/null
BITS=$?
"$RM" -f "$VERSION_LOG"
test ${BITS} -eq 0 && BITS="64" || BITS=""

# ---------------------------------------------------------------------
# Collect JVM options and IDE properties.
# ---------------------------------------------------------------------
if [ -n "$STUDIO_PROPERTIES" ]; then
  IDE_PROPERTIES_PROPERTY="-Didea.properties.file=$STUDIO_PROPERTIES"
fi

VM_OPTIONS=""
VM_OPTIONS_FILES_USED=""
for vm_opts_file in "$IDE_BIN_HOME/studio$BITS.vmoptions" "$OS_SPECIFIC_BIN_DIR/studio$BITS.vmoptions" "$HOME/.AndroidStudio3.0/studio$BITS.vmoptions" "$STUDIO_VM_OPTIONS"; do
  if [ -r "$vm_opts_file" ]; then
    VM_OPTIONS_DATA=`"$CAT" "$vm_opts_file" | "$GREP" -v "^#.*" | "$TR" '\n' ' '`
    VM_OPTIONS="$VM_OPTIONS $VM_OPTIONS_DATA"
    if [ -n "$VM_OPTIONS_FILES_USED" ]; then
      VM_OPTIONS_FILES_USED="$VM_OPTIONS_FILES_USED,"
    fi
    VM_OPTIONS_FILES_USED="$VM_OPTIONS_FILES_USED$vm_opts_file"
  fi
done

IS_EAP="false"
if [ "$IS_EAP" = "true" ]; then
  OS_NAME=`echo "$OS_TYPE" | "$TR" '[:upper:]' '[:lower:]'`
  AGENT_LIB="yjpagent-$OS_NAME$BITS"
  if [ -r "$IDE_BIN_HOME/lib$AGENT_LIB.so" ]; then
    AGENT="-agentlib:$AGENT_LIB=disablealloc,delay=10000,probe_disable=*,sessionname=AndroidStudio3.0"
  fi
fi

CLASSPATH="$IDE_HOME/lib/bootstrap.jar"
CLASSPATH="$CLASSPATH:$IDE_HOME/lib/extensions.jar"
CLASSPATH="$CLASSPATH:$IDE_HOME/lib/util.jar"
CLASSPATH="$CLASSPATH:$IDE_HOME/lib/jdom.jar"
CLASSPATH="$CLASSPATH:$IDE_HOME/lib/log4j.jar"
CLASSPATH="$CLASSPATH:$IDE_HOME/lib/trove4j.jar"
CLASSPATH="$CLASSPATH:$IDE_HOME/lib/jna.jar"
CLASSPATH="$CLASSPATH:$JDK/lib/tools.jar"
if [ -n "$STUDIO_CLASSPATH" ]; then
  CLASSPATH="$CLASSPATH:$STUDIO_CLASSPATH"
fi

if [ -n "$JAVA_TOOL_OPTIONS" -a "$JAVA_TOOL_OPTIONS" != "${JAVA_TOOL_OPTIONS%-javaagent*jayatanaag.jar*}" ] ; then
  export _ORIGINAL_JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS"
  JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS%-javaagent*jayatanaag.jar*}${JAVA_TOOL_OPTIONS#*jayatanaag.jar}"
fi

# ---------------------------------------------------------------------
# Run the IDE.
# ---------------------------------------------------------------------
LD_LIBRARY_PATH="$IDE_BIN_HOME:$LD_LIBRARY_PATH" "$JAVA_BIN" \
  ${AGENT} \
  "-Xbootclasspath/a:$IDE_HOME/lib/boot.jar" \
  -classpath "$CLASSPATH" \
  ${VM_OPTIONS} \
  "-XX:ErrorFile=$HOME/java_error_in_STUDIO_%p.log" \
  "-XX:HeapDumpPath=$HOME/java_error_in_STUDIO.hprof" \
  -Didea.paths.selector=AndroidStudio3.0 \
  "-Djb.vmOptionsFile=$VM_OPTIONS_FILES_USED" \
  ${IDE_PROPERTIES_PROPERTY} \
  -Didea.platform.prefix=AndroidStudio -Didea.jre.check=true \
  com.intellij.idea.Main \
  "$@"