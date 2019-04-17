FROM gitpod/workspace-full:latest

USER gitpod

# Install latest stable version per script
ARG OPENAPI_GENERATOR_VERSION=3.3.4
ARG OPENAPI_PATH=/home/gitpod/bin/openapitools
RUN mkdir -p "$OPENAPI_PATH" && \
    curl https://raw.githubusercontent.com/OpenAPITools/openapi-generator/master/bin/utils/openapi-generator-cli.sh > "$OPENAPI_PATH/openapi-generator-cli" && \
    chmod u+x "$OPENAPI_PATH/openapi-generator-cli" && \
    # Make runnable for gitpod user
    echo "export PATH=$PATH:$OPENAPI_PATH/" >> /home/gitpod/.bashrc && \
    echo "export OPENAPI_GENERATOR_VERSION=$OPENAPI_GENERATOR_VERSION" >> /home/gitpod/.bashrc
# Downloads maven deps as side effect
RUN $OPENAPI_PATH/openapi-generator-cli version

USER root