#/bin/bash
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -exo pipefail

source $(dirname "$0")/test_base_functions.sh
#Set up Java to be used by the netty test
echo_setup

if [ "x$EX_MVN" == "x" ] ; then
 EX_MVN=mvn
fi
MVOPTS="--batch-mode"

pushd jacop-4.0.0
  sed "s;http://;https://;g" -i pom.xml
  sed "s;<version>2.10.3</version>;<version>2.12.12</version>;" -i pom.xml # bumping scala to jdk11+ scala
  sed "s;<maven.compiler.source>1.6</maven.compiler.source>;<maven.compiler.source>8</maven.compiler.source>;g"  -i pom.xml
  sed "s;<maven.compiler.target>1.6</maven.compiler.target>;<maven.compiler.target>8</maven.compiler.target>;g"  -i pom.xml
  $EX_MVN $MVOPTS clean install
popd

