import * as z from 'zod'
import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'

const schema = z.object({
  content: z.string(),
  image_url: z.string().optional()
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
    .from('about')
    .update({
      content: result.data.content,
      ...(result.data.image_url ? { image_url: result.data.image_url } : {}),
      updated_at: new Date().toISOString()
    })
    .eq('id', (await supabase.from('about').select('id').single()).data?.id)
    .select()
    .single()

  if (error) {
    throw createError({ statusCode: 500, statusMessage: error.message })
  }

  return data
})
