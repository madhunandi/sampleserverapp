set -e

# latest commit
LATEST_COMMIT=$(git rev-parse HEAD)

FOLDER1_COMMIT=$(git log -1 --format=format:%H --full-diff ./public)

FOLDER2_COMMIT=$(git log -1 --format=format:%H --full-diff ./src)

if [ $FOLDER1_COMMIT = $LATEST_COMMIT ];
    then
        echo "files in folder1 has changed"
elif [ $FOLDER2_COMMIT = $LATEST_COMMIT ];
    then
        echo "files in folder2 has changed"
        ./scripts/application.sh
else
     echo "no folders of relevance has changed"
     exit 0;
fi