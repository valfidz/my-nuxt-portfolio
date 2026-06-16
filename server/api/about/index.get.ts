import { serverSupabaseClient } from '#supabase/server'

export default defineEventHandler(async (event) => {
  const supabase = await serverSupabaseClient(event)
  const { data, error } = await supabase
    .from('about')
    .select('*')
    .single()

  if (error) {
    throw createError({ statusCode: 404, statusMessage: 'About not found' })
  }

  return data
})
