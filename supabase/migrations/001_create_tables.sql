-- Create projects table
CREATE TABLE IF NOT EXISTS projects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  stacks TEXT[] NOT NULL DEFAULT '{}',
  description TEXT NOT NULL DEFAULT '',
  link TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Create skills table
CREATE TABLE IF NOT EXISTS skills (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  stacks TEXT[] NOT NULL DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Create blogs table
CREATE TABLE IF NOT EXISTS blogs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  content TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'published')),
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Create about table (single row)
CREATE TABLE IF NOT EXISTS about (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  content TEXT NOT NULL DEFAULT '',
  image_url TEXT NOT NULL DEFAULT '/profile_1.png',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE blogs ENABLE ROW LEVEL SECURITY;
ALTER TABLE about ENABLE ROW LEVEL SECURITY;

-- Policies: allow anon select (public read), authenticated full access
CREATE POLICY "Allow public read projects" ON projects FOR SELECT USING (true);
CREATE POLICY "Allow authenticated all projects" ON projects FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Allow public read skills" ON skills FOR SELECT USING (true);
CREATE POLICY "Allow authenticated all skills" ON skills FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Allow public read blogs" ON blogs FOR SELECT USING (true);
CREATE POLICY "Allow authenticated all blogs" ON blogs FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Allow public read about" ON about FOR SELECT USING (true);
CREATE POLICY "Allow authenticated all about" ON about FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

-- Seed data from your hardcoded content
INSERT INTO projects (title, stacks, description, link) VALUES
  ('Simple World Map', ARRAY['Bun', 'Javascript', 'Svelte', 'Sveltekit', 'Supabase', 'Leaflet'], 'Simple world map built by svelte and supabase', 'https://github.com/valfidz/geo-map'),
  ('Pipopa Landing Page', ARRAY['Javascript', 'React.js'], 'Landing page for Pipopa company profile built by React.js', 'https://github.com/valfidz/pipopa-fe/tree/production'),
  ('Pipopa Dashboard', ARRAY['Javascript', 'React.js'], 'Dashboard for Pipopa company profile built by React.js', 'https://github.com/valfidz/admin-compro-cra-pipopa/tree/production'),
  ('Pipopa Backend', ARRAY['Javascript', 'Node.js', 'Express.js', 'MySQL'], 'Backend API for Pipopa company profile built by Express.js and MySQL', 'https://github.com/valfidz/pipopa-be/tree/production');

INSERT INTO skills (title, stacks) VALUES
  ('Backend Development', ARRAY['Node.js', 'Express.js', 'PostgreSQL', 'Laravel', 'Redis', 'Docker', 'Supabase', 'Google Cloud Platform']),
  ('Frontend Development', ARRAY['HTML', 'CSS', 'Javascript', 'React.js', 'Vue.js', 'Nuxt.js']),
  ('Tools & Technologies', ARRAY['Git', 'Linux', 'CI/CD', 'Microservices', 'Rest APIs', 'Testing']),
  ('Soft Skills', ARRAY['Problem Solving', 'Team Collaboration', 'Code Review', 'Agile Development']);

INSERT INTO about (content, image_url) VALUES
  ('<p>Hi, I''m Naufal Hafizh Nugraha, a fullstack developer based in Indonesia.</p><p>I specialize in building and maintaining backend systems using technologies such as Node.js, Express.js, PostgreSQL, Redis, and Kafka. My work mainly focuses on designing APIs, debugging production issues, and improving system reliability in distributed environments.</p><p>My professional experience includes working on high-availability systems for digital document services and e-commerce platforms, where I handled critical incidents, optimized database queries, and stabilized backend services across development, staging, and production environments.</p><p>Currently, I also work as a freelance full-stack developer, building and improving manufacturing reporting systems using Nuxt.js, Laravel, and Microsoft SQL Server. My role involves translating operational requirements into technical implementations and delivering features that support real-world factory workflows.</p><p>My journey into software engineering started as a self-taught developer, where I spent over a year intensively learning web development fundamentals and backend architecture before entering the industry professionally.</p><p>Through this blog, I share what I learn about backend engineering, system design, debugging strategies, and modern web development.</p><p>Outside of coding, I''m interested in continuous learning, building personal projects, and exploring better ways to design reliable software systems.</p>', '/profile_1.png');

INSERT INTO blogs (title, slug, description, content, status, date) VALUES
  ('Building Scalable APIs with Node.js and PostgreSQL', 'building-scalable-apis-with-nodejs-and-postgresql', 'Learn best practices for designing and implementing scalable REST APIs using Node.js, Express, and PostgreSQL. We''ll cover database design, caching strategies, and performance optimization.', $content_lorem$When building modern web applications, creating scalable and efficient APIs is crucial for success. In this comprehensive guide, we'll explore best practices for designing and implementing REST APIs using Node.js and PostgreSQL.

## Why Node.js and PostgreSQL?

Node.js provides excellent performance for I/O-intensive operations, making it ideal for API development. Combined with PostgreSQL's robust ACID compliance and powerful querying capabilities, this stack offers the perfect balance of performance and reliability.

## Database Design Principles

### 1. Normalization vs Denormalization

Start with a normalized database schema to ensure data integrity, then selectively denormalize for performance where needed:

```sql
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
```

### 2. Indexing Strategy

Proper indexing is crucial for query performance:

```sql
-- Index on frequently queried columns
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_created_at ON posts(created_at);

-- Composite index for complex queries
CREATE INDEX idx_posts_user_created ON posts(user_id, created_at);
```

## API Design Best Practices

### 1. RESTful Resource Design

Design your API endpoints around resources, not actions:

```javascript
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
```

### 2. Error Handling

Implement consistent error handling across your API:

```javascript
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
```

## Performance Optimization

### 1. Connection Pooling

Use connection pooling to manage database connections efficiently:

```javascript
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
```

### 2. Caching Strategies

Implement multiple layers of caching:

```javascript
const Redis = require('redis');
const client = Redis.createClient();

// Cache frequently accessed data
const getUserById = async (id) => {
  const cacheKey = `user:${id}`;

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
```

## Security Considerations

### 1. Input Validation

Always validate and sanitize input data:

```javascript
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
```

### 2. Rate Limiting

Protect your API from abuse:

```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP'
});

app.use('/api/', limiter);
```

## Testing Your API

### Unit Tests

```javascript
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
```

## Monitoring and Logging

Implement comprehensive logging and monitoring:

```javascript
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
```

## Conclusion

Building scalable APIs requires careful consideration of database design, performance optimization, security, and monitoring. By following these best practices and leveraging the strengths of Node.js and PostgreSQL, you can create robust APIs that handle growth effectively.

Remember to:
- Design with scalability in mind from the start
- Implement proper error handling and validation
- Use caching strategically
- Monitor your API's performance
- Test thoroughly

Start small, measure performance, and scale incrementally based on real-world usage patterns.$content_lorem$, 'published', '2026-03-11');
