<script setup lang="ts">
import * as z from 'zod'
import type { Form, FormSubmitEvent, EditorToolbarItem  } from '@nuxt/ui';
import type { Editor } from '@tiptap/vue-3'

definePageMeta({
    layout: 'dashboard'
})

const items = [
  [
    {
      icon: 'i-lucide-heading',
      content: {
        align: 'start'
      },
      items: [
        {
          kind: 'heading',
          level: 1,
          icon: 'i-lucide-heading-1',
          label: 'Heading 1'
        },
        {
          kind: 'heading',
          level: 2,
          icon: 'i-lucide-heading-2',
          label: 'Heading 2'
        },
        {
          kind: 'heading',
          level: 3,
          icon: 'i-lucide-heading-3',
          label: 'Heading 3'
        },
        {
          kind: 'heading',
          level: 4,
          icon: 'i-lucide-heading-4',
          label: 'Heading 4'
        }
      ]
    }
  ],
  [
    {
      kind: 'mark',
      mark: 'bold',
      icon: 'i-lucide-bold'
    },
    {
      kind: 'mark',
      mark: 'italic',
      icon: 'i-lucide-italic'
    },
    {
      kind: 'mark',
      mark: 'underline',
      icon: 'i-lucide-underline'
    },
    {
      kind: 'mark',
      mark: 'strike',
      icon: 'i-lucide-strikethrough'
    },
    {
      kind: 'mark',
      mark: 'code',
      icon: 'i-lucide-code'
    }
  ]
] satisfies EditorToolbarItem[][]

const schema = z.object({
    about: z.string(),
    image: z
            .instanceof(File, { message: 'Please select an image' })
            .refine((file) => file.size <= 5 * 1024 * 1024, 'File size must be less than 5MB')
            .refine(
                (file) => ['image/jpeg', 'image/png', 'image/webp'].includes(file.type),
                'Only .jpg, .png, and .webp files are accepted'
            ).optional()
})

// fetch data example
const data  = {
    about: `<p>Hi, I'm Naufal Hafizh Nugraha, a fullstack developer based in Indonesia.</p><p>I specialize in building and maintaining backend systems using technologies such as Node.js, Express.js, PostgreSQL, Redis, and Kafka. My work mainly focuses on designing APIs, debugging production issues, and improving system reliability in distributed environments.</p><p>My professional experience includes working on high-availability systems for digital document services and e-commerce platforms, where I handled critical incidents, optimized database queries, and stabilized backend services across development, staging, and production environments.</p><p>Currently, I also work as a freelance full-stack developer, building and improving manufacturing reporting systems using Nuxt.js, Laravel, and Microsoft SQL Server. My role involves translating operational requirements into technical implementations and delivering features that support real-world factory workflows.</p><p>My journey into software engineering started as a self-taught developer, where I spent over a year intensively learning web development fundamentals and backend architecture before entering the industry professionally.</p><p>Through this blog, I share what I learn about backend engineering, system design, debugging strategies, and modern web development.</p><p>Outside of coding, I'm interested in continuous learning, building personal projects, and exploring better ways to design reliable software systems.</p>`,
    imgPath: '/profile_1.png'
}

const imagePreview = ref<string | null>(data.imgPath)

type Schema = z.output<typeof schema>

const state = reactive<Partial<Schema>>({
    about: data.about,
    image: undefined
})

const toast = useToast()

const onSubmit = async (event: FormSubmitEvent<Schema>) => {
    toast.add({ title: 'Success', description: 'The form has been submitted.', color: 'success' })
    console.log(event.data)

    await navigateTo('/dashboard/about')
}

const createObjUrl = (file: File): string => {
    return URL.createObjectURL(file)
}

watch(() => state.image, (file) => {
    if (file) {
        imagePreview.value = createObjUrl(file)
    }
})
</script>

<template>
    <UContainer>
        <UButton
            label="Back to About"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost"
            size="lg"
            :ui="{
                base: 'mt-10'
            }"
            to="/dashboard/about"
        />

        <UPageHeader
            title="Edit About"
            :ui="{
                root: 'border-b-0'
            }"
        />

        <UCard class="mb-20">
            <UForm
                :schema="schema"
                :state="state"
                @submit="onSubmit"
                class="flex flex-col gap-6"
            >
                <UFormField label="About" name="about" :ui="{ label: 'text-2xl font-semibold' }">
                    <UEditor
                        v-slot="{ editor }"
                        v-model="state.about"
                        content-type="html"
                        :ui="{ base: 'p-8 sm:px-16' }"
                        class="w-full min-h-74"
                    >
                        <UEditorToolbar
                            :editor="editor"
                            :items="items"
                            class="border-b border-muted py-2 px-8 sm:px-16 overflow-x-auto"
                        />
                    </UEditor>
                </UFormField>

                <UFormField label="Image" name="image" :ui="{ label: 'text-2xl font-semibold' }">
                    <UFileUpload
                        size="xl"
                        variant="area"
                        label="Drop your image here"
                        description="PNG, JPG, or WEBP (max. 5MB)"
                        v-slot="{ open, removeFile }"
                        v-model="state.image"
                        accept="image/jpeg,image/png,image/webp"
                    >
                        <!-- Show current/new image preview -->
                        <img
                            v-if="imagePreview"
                            :src="imagePreview"
                            class="w-100 h-100 object-cover rounded-lg border border-default"
                            alt="Profile Image"
                        />

                        <div class="flex gap-2">
                            <UButton
                                :label="state.image ? 'Change image' : 'Upload new image'"
                                color="neutral"
                                variant="outline"
                                icon="i-lucide-upload"
                                @click="open()"
                            />

                            <UButton
                                v-if="state.image"
                                label="Remove"
                                color="error"
                                variant="outline"
                                @click="() => { removeFile(); imagePreview = data.imgPath }"
                            />
                        </div>

                        <p v-if="state.image" class="text-xs text-muted">
                            {{ state.image.name }}
                        </p>
                    </UFileUpload>
                </UFormField>

                <UButton
                    type="submit"
                    class="max-w-20 justify-center"
                    color="neutral"
                    size="xl"
                >
                    Submit
                </UButton>
            </UForm>
        </UCard>
    </UContainer>
</template>