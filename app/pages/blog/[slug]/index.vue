<script setup lang="ts">
import { marked } from 'marked'
import type { ContentTocLink } from '@nuxt/ui'

definePageMeta({
    layout: 'main'
})

type Posts = {
    title: string
    slug: string
    description: string
    date: string
    to: string
    tags: string[]
    content: string
}

const route = useRoute()
const slug = ref(route.params.slug)

// later change with data from database
const posts = ref<Posts[]>([
  {
    title: 'Building Scalable APIs with Node.js and PostgreSQL',
    slug: 'building-scalable-apis-with-nodejs-and-postgreqsql',
    description: `Learn best practices for designing and implementing scalable REST APIs using Node.js, Express, and PostgreSQL. We'll cover database design, caching strategies, and performance optimization.`,
    date: '2026-03-11',
    to: '/blog/building-scalable-apis-with-nodejs-and-postgreqsql',
    tags: ['Node.js', 'PostgreSQL', 'API Design', 'Backend'],
    content: `

When building modern web applications, creating scalable and efficient APIs is crucial for success. In this comprehensive guide, we'll explore best practices for designing and implementing REST APIs using Node.js and PostgreSQL.

## Why Node.js and PostgreSQL?

Node.js provides excellent performance for I/O-intensive operations, making it ideal for API development. Combined with PostgreSQL's robust ACID compliance and powerful querying capabilities, this stack offers the perfect balance of performance and reliability.

## Database Design Principles

### 1. Normalization vs Denormalization

Start with a normalized database schema to ensure data integrity, then selectively denormalize for performance where needed:

\`\`\`sql
-- Users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Posts table with foreign key
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  title VARCHAR(255) NOT NULL,
  content TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
\`\`\`

### 2. Indexing Strategy

Proper indexing is crucial for query performance:

\`\`\`sql
-- Index on frequently queried columns
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_created_at ON posts(created_at);

-- Composite index for complex queries
CREATE INDEX idx_posts_user_created ON posts(user_id, created_at);
\`\`\`

## API Design Best Practices

### 1. RESTful Resource Design

Design your API endpoints around resources, not actions:

\`\`\`javascript
// Good: Resource-based URLs
GET    /api/users           // Get all users
GET    /api/users/:id       // Get specific user
POST   /api/users           // Create user
PUT    /api/users/:id       // Update user
DELETE /api/users/:id       // Delete user

// Bad: Action-based URLs
POST   /api/createUser
POST   /api/updateUser
POST   /api/deleteUser
\`\`\`

### 2. Error Handling

Implement consistent error handling across your API:

\`\`\`javascript
class ApiError extends Error {
  constructor(statusCode, message, isOperational = true) {
    super(message);
    this.statusCode = statusCode;
    this.isOperational = isOperational;
    Error.captureStackTrace(this, this.constructor);
  }
}

const errorHandler = (err, req, res, next) => {
  const { statusCode = 500, message } = err;

  res.status(statusCode).json({
    status: 'error',
    statusCode,
    message: statusCode === 500 ? 'Internal server error' : message
  });
};
\`\`\`

## Performance Optimization

### 1. Connection Pooling

Use connection pooling to manage database connections efficiently:

\`\`\`javascript
const { Pool } = require('pg');

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
  max: 20, // Maximum number of connections
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});
\`\`\`

### 2. Caching Strategies

Implement multiple layers of caching:

\`\`\`javascript
const Redis = require('redis');
const client = Redis.createClient();

// Cache frequently accessed data
const getUserById = async (id) => {
  const cacheKey = \`user:\${id}\`;

  // Try cache first
  const cached = await client.get(cacheKey);
  if (cached) {
    return JSON.parse(cached);
  }

  // Query database
  const result = await pool.query('SELECT * FROM users WHERE id = $1', [id]);
  const user = result.rows[0];

  // Cache for 5 minutes
  await client.setex(cacheKey, 300, JSON.stringify(user));

  return user;
};
\`\`\`

## Security Considerations

### 1. Input Validation

Always validate and sanitize input data:

\`\`\`javascript
const { body, validationResult } = require('express-validator');

const validateUser = [
  body('email').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    next();
  }
];
\`\`\`

### 2. Rate Limiting

Protect your API from abuse:

\`\`\`javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP'
});

app.use('/api/', limiter);
\`\`\`

## Testing Your API

### Unit Tests

\`\`\`javascript
const request = require('supertest');
const app = require('../app');

describe('GET /api/users', () => {
  it('should return all users', async () => {
    const res = await request(app)
      .get('/api/users')
      .expect(200);

    expect(res.body).toHaveProperty('users');
    expect(Array.isArray(res.body.users)).toBe(true);
  });
});
\`\`\`

## Monitoring and Logging

Implement comprehensive logging and monitoring:

\`\`\`javascript
const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});

// Log API requests
app.use((req, res, next) => {
  logger.info({
    method: req.method,
    url: req.url,
    ip: req.ip,
    userAgent: req.get('User-Agent')
  });
  next();
});
\`\`\`

## Conclusion

Building scalable APIs requires careful consideration of database design, performance optimization, security, and monitoring. By following these best practices and leveraging the strengths of Node.js and PostgreSQL, you can create robust APIs that handle growth effectively.

Remember to:
- Design with scalability in mind from the start
- Implement proper error handling and validation
- Use caching strategically
- Monitor your API's performance
- Test thoroughly

Start small, measure performance, and scale incrementally based on real-world usage patterns.
    `
  },
])

let thisPost = computed(() => posts.value.filter((post: Posts) => post.slug === slug.value))

const formattedDate = computed(() => {
    const post = thisPost.value[0]
    if (!post) return ''
    return new Date(post.date).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    })
})

// Set up custom renderer BEFORE parsedContent so headings get IDs
const renderer = new marked.Renderer()
renderer.heading = ({ text, depth }) => {
  const id = text.toLowerCase().replace(/[^\w\s-]/g, '').replace(/\s+/g, '-')
  return `<h${depth} id="${id}">${text}</h${depth}>`
}
marked.use({ renderer })

const parsedContent = computed(() => {
  const content = thisPost.value[0]?.content
  if (!content) return ''
  return marked(content)
})

// Generate TOC links from markdown headings
const tocLinks = computed<ContentTocLink[]>(() => {
  const content = thisPost.value[0]?.content
  if (!content) return []

  const tokens = marked.lexer(content)
  const links: ContentTocLink[] = []

  for (const token of tokens) {
    if (token.type === 'heading') {
      const id = token.text
        .toLowerCase()
        .replace(/[^\w\s-]/g, '')
        .replace(/\s+/g, '-')

      const link: ContentTocLink = {
        id,
        text: token.text,
        depth: token.depth,
      }

      if (token.depth === 2) {
        links.push(link)
      } else if (token.depth === 3) {
        const parent = links[links.length - 1]
        if (parent) {
          if (!parent.children) parent.children = []
          parent.children.push(link)
        }
      }
    }
  }

  return links
})

// Mobile TOC accordion state
const tocOpen = ref(false)
</script>

<template>
  <UPage>
    <UContainer class="mt-10 pb-16">

      <UButton
        icon="i-lucide-arrow-left"
        label="Back to blog"
        color="neutral"
        variant="ghost"
        size="xl"
        to="/blog"
      />

      <!-- Meta row -->
      <div class="mt-6 flex flex-row gap-6">
        <div class="flex flex-row gap-2 items-center">
          <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 2v4"/><path d="M16 2v4"/><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/></svg>
          <p>{{ formattedDate }}</p>
        </div>
        <div class="flex flex-row gap-2 items-center">
          <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>
          <p>8 min read</p>
        </div>
      </div>

      <UPageHeader
        :title="thisPost[0]?.title"
        :ui="{ root: 'border-b-0' }"
      />

      <div class="flex flex-row gap-2 flex-wrap">
        <UBadge
          v-for="(stack, index) in thisPost[0]?.tags"
          :key="index"
          :label="stack"
          color="neutral"
        />
      </div>

      <!-- Mobile TOC accordion (hidden on lg+) -->
      <div v-if="tocLinks.length" class="lg:hidden mt-6 border border-default rounded-lg overflow-hidden">
        <button
          class="w-full flex items-center justify-between px-4 py-3 text-sm font-semibold bg-muted/40 hover:bg-muted/70 transition-colors"
          @click="tocOpen = !tocOpen"
        >
          <span>On this page</span>
          <svg
            xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
            fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
            :class="['transition-transform duration-200', tocOpen ? 'rotate-180' : '']"
          >
            <path d="m6 9 6 6 6-6"/>
          </svg>
        </button>
        <div v-if="tocOpen" class="px-4 py-3 border-t border-default">
          <ul class="space-y-1 border-l border-default">
            <template v-for="link in tocLinks" :key="link.id">
              <li>
                <a
                  :href="`#${link.id}`"
                  class="block text-sm text-muted hover:text-default transition-colors py-1 pl-4"
                  @click="tocOpen = false"
                >
                  {{ link.text }}
                </a>
              </li>
              <li v-for="child in link.children" :key="child.id">
                <a
                  :href="`#${child.id}`"
                  class="block text-sm text-muted hover:text-default transition-colors py-1 pl-7"
                  @click="tocOpen = false"
                >
                  {{ child.text }}
                </a>
              </li>
            </template>
          </ul>
        </div>
      </div>

      <!-- Article content -->
      <div class="prose prose-neutral dark:prose-invert max-w-none mt-8" v-html="parsedContent" />

    </UContainer>

    <!-- Desktop sticky TOC in right slot (shown on lg+) -->
    <template v-if="tocLinks.length" #right>
      <div class="sticky top-[calc(var(--ui-header-height,64px)+2rem)] max-h-[calc(100vh-var(--ui-header-height,64px)-4rem)] overflow-y-auto space-y-2 hidden lg:block">
        <p class="text-sm font-semibold">On this page</p>
        <ul class="space-y-1 border-l border-default">
          <template v-for="link in tocLinks" :key="link.id">
            <li>
              <a
                :href="`#${link.id}`"
                class="block text-sm text-muted hover:text-default transition-colors py-1 pl-4"
              >
                {{ link.text }}
              </a>
            </li>
            <li v-for="child in link.children" :key="child.id">
              <a
                :href="`#${child.id}`"
                class="block text-sm text-muted hover:text-default transition-colors py-1 pl-7"
              >
                {{ child.text }}
              </a>
            </li>
          </template>
        </ul>
      </div>
    </template>

  </UPage>
</template>