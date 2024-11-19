set -exo pipefail
if [ "x$EX_MVN" == "x" ] ; then
 EX_MVN=mvn
fi
MVOPTS="--batch-mode"

echo $JAVA_HOME
export JAVA_HOME=$(readlink -f $JAVA_HOME)
ls -l  `dirname $JAVA_HOME`
ls -l  $JAVA_HOME

rm -rf jacop
mkdir jacop
pushd jacop
  wget https://github.com/radsz/jacop/archive/v4.0.0.tar.gz
  tar -xf v4.0.0.tar.gz
  pushd jacop-4.0.0
    sed "s;http://;https://;g" -i pom.xml
    sed "s;<version>2.10.3</version>;<version>2.12.12</version>;" -i pom.xml # bumping scala to jdk11+ scala
    sed "s;<maven.compiler.source>1.6</maven.compiler.source>;<maven.compiler.source>8</maven.compiler.source>;g"  -i pom.xml
    sed "s;<maven.compiler.target>1.6</maven.compiler.target>;<maven.compiler.target>8</maven.compiler.target>;g"  -i pom.xml
    $EX_MVN $MVOPTS clean install
  popd
popd

