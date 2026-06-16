import * as z from 'zod'
import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'

const schema = z.object({
  title: z.string().min(1, 'Title is required'),
  description: z.string().default(''),
  content: z.string().default(''),
  status: z.enum(['draft', 'published']).default('draft'),
  date: z.string()
})

type Schema = z.output<typeof schema>

export default defineEventHandler(async (event) => {
  const user = await serverSupabaseUser(event)
  if (!user) {
    throw createError({ statusCode: 401, statusMessage: 'Unauthorized' })
  }

  const slug = getRouterParam(event, 'slug')

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
  const { data, error } = await supabase
    .from('blogs')
    .update({
      title: result.data.title,
      slug: result.data.title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, ''),
      description: result.data.description,
      content: result.data.content,
      status: result.data.status,
      date: result.data.date,
      updated_at: new Date().toISOString()
    })
    .eq('slug', slug)
    .select()
    .single()

  if (error) {
    throw createError({ statusCode: 500, statusMessage: error.message })
  }

  return data
})
