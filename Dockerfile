# Use the official Metabase image
FROM metabase/metabase:latest

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the port that Render expects (Render uses PORT env var)
EXPOSE 10000

# Use our entrypoint wrapper that converts PORT to MB_JETTY_PORT
ENTRYPOINT ["/entrypoint.sh"]

