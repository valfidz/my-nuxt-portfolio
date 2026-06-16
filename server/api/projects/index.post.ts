import * as z from 'zod'
import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'

const schema = z.object({
  title: z.string().min(1, 'Title is required'),
  stacks: z.array(z.string()).default([]),
  description: z.string().default(''),
  link: z.string().default('')
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
  const { data, error } = await supabase
    .from('projects')
    .insert({
      title: result.data.title,
      stacks: result.data.stacks,
      description: result.data.description,
      link: result.data.link
    })
    .select()
    .single()

  if (error) {
    throw createError({ statusCode: 500, statusMessage: error.message })
  }

  return data
})
