# Use the official Metabase image
FROM metabase/metabase:latest

# Expose the port that Render expects
EXPOSE 10000

# The Metabase image handles everything
# Port and memory configuration via environment variables

