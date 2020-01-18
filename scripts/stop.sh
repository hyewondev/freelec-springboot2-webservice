ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

IDLE_PORT=$(find_idle_port)

echo "> $IDLE_PORT checking running application pid"
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PID} ]
then
  echo "> It is not stopping because there is no application running"
else
  echo "> kill -15 $IDLE_PID"
  kill -15 ${IDLE_PID}
  SLEEP 5
FI
