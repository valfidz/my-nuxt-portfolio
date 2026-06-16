# Fullstack Portfolio

A modern, full-stack portfolio web application built with **Nuxt 4**, **Vue 3**, **Tailwind CSS**, and **Supabase**. This project showcases personal projects, blog posts, and professional information with an integrated authentication system.

## Features

- 📱 Responsive design with Tailwind CSS
- 🔐 User authentication with Supabase
- 📝 Blog system with markdown support
- 💼 Project showcase
- 🎨 Admin dashboard for content management
- 🖼️ Image optimization with Nuxt Image
- ⚡ Server-side rendering and static generation options
- 🎯 SEO optimized

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Environment Setup](#environment-setup)
- [Development](#development)
- [Production](#production)
- [Project Structure](#project-structure)
- [Technologies](#technologies)

## Requirements

Before you begin, ensure you have the following installed:

### System Requirements
- **Node.js**: v18.0.0 or higher
- **npm**: v9.0.0 or higher (or **yarn** / **pnpm** as alternative package managers)

### External Services
- **Supabase Account**: For authentication and database ([Create account](https://supabase.com))
  - Supabase project URL
  - Supabase API key (public/anon key)

### Recommended Tools
- **Git**: For version control
- **Visual Studio Code**: Recommended code editor

## Installation

### Step 1: Clone the Repository

```bash
git clone <your-repository-url>
cd fullstack
```

### Step 2: Install Dependencies

Using npm:
```bash
npm install
```

Or if you prefer yarn:
```bash
yarn install
```

Or if you prefer pnpm:
```bash
pnpm install
```

**Note**: After installation, `postinstall` script will automatically run `nuxt prepare` to prepare the Nuxt environment.

### Step 3: Environment Setup

Create a `.env.local` file in the root directory with the following environment variables:

```env
# Supabase Configuration
NUXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NUXT_PUBLIC_SUPABASE_KEY=your_supabase_anon_key
```

**How to get your Supabase credentials:**

1. Go to [Supabase Dashboard](https://app.supabase.com)
2. Create a new project or select an existing one
3. Navigate to **Settings** → **API**
4. Copy:
   - **Project URL** → `NUXT_PUBLIC_SUPABASE_URL`
   - **Anon / public key** → `NUXT_PUBLIC_SUPABASE_KEY`

5. Save these values in your `.env.local` file

**Important**: 
- ⚠️ Never commit `.env.local` to version control
- Add `.env.local` to your `.gitignore` file
- Use different Supabase projects for development and production

## Development

### Running the Development Server

Start the development server with hot-reload:

```bash
npm run dev
```

The application will be available at:
- **URL**: [http://localhost:3000](http://localhost:3000)
- **Hot Module Replacement**: Enabled for instant updates as you make changes

### Development Features

- Nuxt DevTools enabled for debugging and inspection
- Real-time code updates without page refresh
- Source maps for easier debugging
- Vue component inspection

### Development Commands

```bash
# Start development server
npm run dev

# Build for production (without running)
npm run build

# Preview production build locally
npm run preview

# Generate static site
npm run generate
```

## Production

### Step 1: Build the Application

Create an optimized production build:

```bash
npm run build
```

This command:
- Compiles and minifies the entire application
- Optimizes assets and images
- Generates production-ready output in `.output` directory
- May take a few minutes depending on project size

### Step 2: Preview Production Build (Optional)

To test the production build locally before deployment:

```bash
npm run preview
```

Access the preview at [http://localhost:3000](http://localhost:3000)

### Step 3: Deploy to Production

Choose your preferred hosting platform:

#### Option 1: Vercel (Recommended for Nuxt)
```bash
npm install -g vercel
vercel
```
Follow the prompts to deploy your application.

#### Option 2: Netlify
```bash
npm install -g netlify-cli
netlify deploy --prod --dir=.output/public
```

#### Option 3: Other Platforms (AWS, Heroku, DigitalOcean, etc.)
Ensure your platform:
- Supports Node.js v18+
- Can run the `.output` directory
- Has proper environment variables set (Supabase credentials)

### Production Environment Variables

Set the same environment variables on your production server:

```env
NUXT_PUBLIC_SUPABASE_URL=your_production_supabase_project_url
NUXT_PUBLIC_SUPABASE_KEY=your_production_supabase_anon_key
```

**Important for Production:**
- Use a separate Supabase project for production
- Never expose your service role key publicly
- Use strong API keys and credentials
- Enable appropriate RLS (Row Level Security) policies on Supabase
- Set up proper CORS policies
- Enable HTTPS
- Configure secure cookie settings

### Production Monitoring

- Set up error tracking (e.g., Sentry)
- Monitor performance metrics
- Set up logging and alerting
- Regularly backup your Supabase database

## Project Structure

```
fullstack/
├── app/
│   ├── assets/
│   │   └── css/
│   │       └── main.css          # Global styles
│   ├── components/
│   │   ├── Auth.vue              # Authentication component
│   │   └── main/                 # Main layout components
│   │       ├── about.vue
│   │       ├── blog.vue
│   │       ├── contact.vue
│   │       ├── header.vue
│   │       ├── project.vue
│   │       └── skills.vue
│   ├── layouts/
│   │   ├── main.vue              # Main layout
│   │   └── dashboard.vue         # Dashboard layout
│   ├── pages/
│   │   ├── index.vue             # Home page
│   │   ├── login.vue             # Login page
│   │   ├── register/index.vue    # Registration page
│   │   ├── blog/                 # Blog pages
│   │   │   └── [slug]/           # Dynamic blog post page
│   │   └── dashboard/            # Admin dashboard
│   │       ├── about/
│   │       ├── blogs/
│   │       ├── projects/
│   │       └── skills/
│   └── app.vue                   # Root component
├── public/
│   └── robots.txt                # SEO robots file
├── nuxt.config.ts                # Nuxt configuration
├── tsconfig.json                 # TypeScript configuration
├── package.json                  # Project dependencies
└── README.md                      # This file
```

## Technologies

### Frontend Framework
- **Nuxt 4.3.1**: Full-stack Vue framework
- **Vue 3.5.29**: Progressive JavaScript framework
- **TypeScript**: Typed JavaScript

### Styling
- **Tailwind CSS 4.2.1**: Utility-first CSS framework
- **Tailwind Typography**: Beautiful typography styles

### UI & Components
- **Nuxt UI**: Component library built on Headless UI
- **Nuxt Image**: Image optimization and responsive images
- **Iconify (Lucide)**: Icon library

### Content & Data
- **Nuxt Content**: Markdown content management
- **Marked 17.0.4**: Markdown parser
- **DOMPurify 3.3.2**: HTML sanitization

### Authentication & Backend
- **Supabase**: Open-source Firebase alternative
  - Authentication
  - Real-time database
  - Row Level Security (RLS)
- **@nuxtjs/supabase**: Nuxt wrapper for Supabase

### Development Tools
- **Nuxt DevTools**: Development utilities and debugging

## Troubleshooting

### Port 3000 Already in Use

If port 3000 is already in use, you can specify a different port:

```bash
npm run dev -- --port 3001
```

### Environment Variables Not Loading

1. Ensure `.env.local` is in the root directory
2. Restart the development server after changing `.env.local`
3. Check that variable names start with `NUXT_PUBLIC_` for public variables
4. Verify Supabase credentials are correct

### Supabase Connection Issues

1. Verify Supabase project is active
2. Check Supabase URL and API key in `.env.local`
3. Ensure CORS policies are configured properly
4. Check browser console for error messages
5. Verify network connectivity

### Build Failures

1. Clear node_modules: `rm -rf node_modules && npm install`
2. Clear Nuxt cache: `rm -rf .nuxt`
3. Check for TypeScript errors: `npx nuxi typecheck`
4. Review console output for specific error messages

## Getting Help

- [Nuxt Documentation](https://nuxt.com)
- [Vue 3 Documentation](https://vuejs.org)
- [Tailwind CSS Documentation](https://tailwindcss.com)
- [Supabase Documentation](https://supabase.com/docs)
- [Nuxt UI Documentation](https://ui.nuxt.com)

## License

This project is private. Please check with the owner for usage rights.

## Support

For issues, questions, or contributions, please contact the project maintainer.

---

**Last Updated**: 2026-05-13  
**Nuxt Version**: 4.3.1  
**Node Version Requirement**: 18.0.0+
