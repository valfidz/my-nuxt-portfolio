import * as z from 'zod'
import { serverSupabaseClient } from '#supabase/server'

const schema = z.object({
  fullName: z.string(),
  email: z.email('Invalid email'),
  password: z.string('Password is required').min(8, 'Must be at least 8 characters'),
  confirmPassword: z.string('Password is required').min(8, 'Must be at least 8 characters'),
  role: z.enum(["Endmin", "Endfielder"]),
  secret: z.string()
})

type Schema = z.output<typeof schema>
type Role = Schema['role']

type Database = {
  public: {
    Tables: {
      user_profile: {
        Row: {
          id: string
          full_name: string
          role: Role
          email: string
        }
        Insert: {
          id: string
          full_name: string
          role: Role
          email: string
        }
        Update: {
          id?: string
          full_name?: string
          role?: Role
          email?: string
        }
        Relationships: []
      }
    }
    Views: Record<string, never>
    Functions: Record<string, never>
    Enums: Record<string, never>
    CompositeTypes: Record<string, never>
  }
}

export default defineEventHandler(async (event) => {
  const secret = process.env.SECRET_KEY_SIGNUP
  const body = await readBody(event)
  const result = schema.safeParse(body)

  if (!result.success) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Validation failed',
      data: result.error.flatten()
    })
  }

  const data = result.data

  if (data.secret !== secret) {
    throw createError({
        statusCode: 400,
        statusMessage: 'Secret key is needed',
    })
  }

  if (data.password !== data.confirmPassword) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Password does not match'
    })
  }

  try {
      const supabase = await serverSupabaseClient<Database>(event)
    
      const { data: signUpData, error: signUpError } = await supabase.auth.signUp({
        email: data.email,
        password: data.password,
        options: {
          data: {
            full_name: data.fullName,
            role: data.role
          }
        }
      })
    
      if (signUpError) {
        throw createError({
          statusCode: signUpError.status || 400,
          statusMessage: signUpError.message
        })
      }
    
      if (!signUpData.user) {
        throw createError({
          statusCode: 400,
          statusMessage: 'Failed to create user'
        })
      }
    
      const { error: profileError } = await supabase
        .from('user_profile')
        .upsert({
          id: signUpData.user.id,
          full_name: data.fullName,
          role: data.role,
          email: data.email
        })
    
      if (profileError) {
        throw createError({
          statusCode: 400,
          statusMessage: profileError.message
        })
      }
    
      return {
        message: 'Register success',
        user: {
          id: signUpData.user.id,
          email: signUpData.user.email
        }
      }
  } catch (error) {
    if (error && typeof error === 'object' && 'statusCode' in error) {
      throw error
    }

    throw createError({
      statusCode: 500,
      statusMessage: error instanceof Error ? error.message : 'Internal server error'
    })
  }
})
