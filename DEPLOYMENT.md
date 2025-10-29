# Deploying Metabase to Render

This guide will help you deploy your Metabase instance to Render.com.

## Prerequisites
1. A Render.com account (sign up at https://render.com)
2. Your code pushed to a Git repository (GitHub, GitLab, or Bitbucket)

## Deployment Steps

### Option 1: Using Render Dashboard (Recommended)

1. **Push your code to GitHub/GitLab/Bitbucket**
   - Make sure all files (docker-compose.yml, Dockerfile, render.yaml) are committed and pushed

2. **Create a new Web Service on Render**
   - Go to your Render dashboard
   - Click "New +" → "Web Service"
   - Connect your repository
   - Render will automatically detect the `render.yaml` file

3. **Configure the Service**
   - **Name**: metabase (or your preferred name)
   - **Environment**: Docker
   - **Region**: Choose closest to you
   - **Branch**: main (or your default branch)
   - **Root Directory**: . (or leave empty)
   - **Plan**: Starter ($7/month) or Free tier if available
   
4. **Add Persistent Disk** (Important!)
   - In the service settings, go to "Disks"
   - Click "Link Existing Disk" or "Create Disk"
   - Name: `metabase-disk`
   - Mount Path: `/metabase-data`
   - Size: 1GB (minimum, increase if needed)

5. **Environment Variables**
   - Go to "Environment" tab
   - Add: `MB_DB_FILE` = `/metabase-data/metabase.db`
   - Optionally add: `MB_JETTY_PORT` = `10000` (Render uses port 10000 by default)

6. **Deploy**
   - Click "Create Web Service"
   - Render will build and deploy your service
   - Once deployed, you'll get a URL like: `https://metabase-xxxx.onrender.com`

### Option 2: Using Render CLI

1. Install Render CLI
   ```bash
   npm install -g render-cli
   ```

2. Login to Render
   ```bash
   render login
   ```

3. Deploy using the render.yaml
   ```bash
   render deploy
   ```

## Important Notes

⚠️ **Free Tier Limitations:**
- Services on free tier spin down after 15 minutes of inactivity
- First request after spin-down takes 30-60 seconds to wake up
- Consider upgrading to paid plan for production use

⚠️ **Database Persistence:**
- Your Metabase data is stored on the persistent disk at `/metabase-data`
- This ensures your data persists across deployments

⚠️ **Port Configuration:**
- Render uses port 10000 for web services
- Metabase should automatically detect this, but if not, set `MB_JETTY_PORT=10000`

## Post-Deployment

1. **Access Metabase**
   - Visit your Render service URL
   - Complete the initial Metabase setup wizard
   - Create your admin account

2. **Configure Auto-Deploy** (Optional)
   - In Render dashboard → Settings → Build & Deploy
   - Enable "Auto-Deploy" to automatically deploy on git push

3. **Custom Domain** (Optional)
   - In Render dashboard → Settings → Custom Domains
   - Add your custom domain

## Troubleshooting

- **Service won't start**: Check logs in Render dashboard
- **Database not persisting**: Verify disk is mounted at `/metabase-data`
- **Port errors**: Ensure `MB_JETTY_PORT=10000` is set
- **Slow first load**: Normal on free tier due to spin-down

## Alternative: Using PostgreSQL

For production, consider using an external PostgreSQL database instead of the file-based H2 database:
- Set `MB_DB_TYPE=postgres`
- Set `MB_DB_DBNAME`, `MB_DB_USER`, `MB_DB_PASS`, `MB_DB_HOST`, `MB_DB_PORT`
- Use Render's PostgreSQL add-on or external database

