import { serverSupabaseClient } from '#supabase/server'

export default defineEventHandler(async (event) => {
  const slug = getRouterParam(event, 'slug')

  const supabase = await serverSupabaseClient(event)
  const { data, error } = await supabase
    .from('blogs')
    .select('*')
    .eq('slug', slug)
    .single()

  if (error) {
    throw createError({ statusCode: 404, statusMessage: 'Blog post not found' })
  }

  return data
})
