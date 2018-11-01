#!/usr/bin/env bash

set -e


sudo yarn global add now --prefix /
cd public
export ENV_NAME=PRODUCTION
if [[ -z ${CIRCLE_TAG} ]]; then export ENV_NAME=STAGING; fi
echo "Building for environment", ${ENV_NAME}
for key in $(compgen -e); do if [[ ${key} == "${ENV_NAME}"* ]]; then new_variable=$(echo "${key}" | grep ^"${ENV_NAME}" | sed s/^"${ENV_NAME}"_//); export "${new_variable}"="${!key}"; fi; done
DEPLOYMENT_DOMAIN=$(now deploy --team ${NOW_TEAM} --token ${NOW_TOKEN} -e FIREBASE_API_KEY -e FIREBASE_AUTH_DOMAIN -e FIREBASE_DATABASE_URL -e FIREBASE_PROJECT_ID -e FIREBASE_STORAGE_BUCKET -e GA_TAG -e NODE_ENV -e SENTRY_DSN -e INTERCOM)
echo ${DEPLOYMENT_DOMAIN}