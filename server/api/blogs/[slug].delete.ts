import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'

export default defineEventHandler(async (event) => {
  const user = await serverSupabaseUser(event)
  if (!user) {
    throw createError({ statusCode: 401, statusMessage: 'Unauthorized' })
  }

  const slug = getRouterParam(event, 'slug')

  const supabase = await serverSupabaseClient(event)
  const { error } = await supabase
    .from('blogs')
    .delete()
    .eq('slug', slug)

  if (error) {
    throw createError({ statusCode: 500, statusMessage: error.message })
  }

  return { success: true }
})
