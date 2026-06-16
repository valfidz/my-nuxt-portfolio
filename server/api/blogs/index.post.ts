import * as z from 'zod'
import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'

const schema = z.object({
  title: z.string().min(1, 'Title is required'),
  description: z.string().default(''),
  content: z.string().default(''),
  status: z.enum(['draft', 'published']).default('draft'),
  date: z.string().default(() => new Date().toISOString().split('T')[0])
})

type Schema = z.output<typeof schema>

export default defineEventHandler(async (event) => {
  const user = await serverSupabaseUser(event)
  if (!user) {
    throw createError({ statusCode: 401, statusMessage: 'Unauthorized' })
  }

  const body = await readBody(event)
  const result = schema.safeParse(body)

  if (!result.success) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Validation failed',
      data: result.error.flatten()
    })
  }

  const supabase = await serverSupabaseClient(event)
  const slug = result.data.title
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '')

  const { data, error } = await supabase
    .from('blogs')
    .insert({
      title: result.data.title,
      slug,
      description: result.data.description,
      content: result.data.content,
      status: result.data.status,
      date: result.data.date
    })
    .select()
    .single()

  if (error) {
    throw createError({ statusCode: 500, statusMessage: error.message })
  }

  return data
})
