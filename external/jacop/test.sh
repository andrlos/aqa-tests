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

$EX_MVN $MVOPTS clean install

test_exit_code=$?
echo "Build jacop completed"

echo `pwd`
echo `ls /`
echo `find .`
echo `find / -type d -name 'surefire-reports'`
find ./ -type d -name 'surefire-reports' -exec cp -r "{}" /testResults \;
echo `ls /testResults`
echo "Test results copied"

exit $test_exit_code
