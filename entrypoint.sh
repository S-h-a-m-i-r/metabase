#!/bin/sh
set -e

# Use Render's PORT environment variable for Metabase
if [ -n "$PORT" ]; then
  export MB_JETTY_PORT="$PORT"
fi

# Ensure Metabase binds to all interfaces (required for Render)
export MB_JETTY_HOST="0.0.0.0"

# Start Metabase - use the default entrypoint or fallback to java
if [ -f /app/run_metabase.sh ]; then
  exec /app/run_metabase.sh "$@"
else
  # Fallback: start Metabase directly
  exec java -XX:+IgnoreUnrecognizedVMOptions -Dfile.encoding=UTF-8 \
    -Dlog4j.shutdownHookEnabled=false -Dlog4j2.disable.jmx=true \
    -Djava.security.egd=file:/dev/./urandom \
    $JAVA_TOOL_OPTIONS \
    -cp /app/server.jar metabase.core "$@"
fi

