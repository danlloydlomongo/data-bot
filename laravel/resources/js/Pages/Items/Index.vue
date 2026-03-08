<template>
    <div class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900">
        <header class="border-b border-gray-700/50">
            <div class="max-w-4xl mx-auto px-6 py-4 flex items-center justify-between">
                <a href="/" class="text-indigo-400 hover:text-indigo-300 font-medium">← Back</a>
                <h1 class="text-xl font-bold text-white">Items</h1>
                <Link href="/items/create" class="px-4 py-2 bg-indigo-500 hover:bg-indigo-400 text-white text-sm font-medium rounded-lg transition">
                    New Item
                </Link>
            </div>
        </header>

        <main class="max-w-4xl mx-auto px-6 py-8">
            <div v-if="items.length === 0" class="text-center py-16 text-gray-400">
                No items yet. <Link href="/items/create" class="text-indigo-400 hover:text-indigo-300">Create one</Link>.
            </div>

            <ul v-else class="space-y-4">
                <li
                    v-for="item in items"
                    :key="item.id"
                    class="bg-gray-800/50 border border-gray-700/50 rounded-xl p-4 flex items-center justify-between hover:border-gray-600 transition"
                >
                    <div>
                        <h2 class="font-semibold text-white">{{ item.title }}</h2>
                        <p v-if="item.description" class="text-sm text-gray-400 mt-1 line-clamp-2">{{ item.description }}</p>
                    </div>
                    <div class="flex items-center gap-2 ml-4">
                        <Link :href="`/items/${item.id}/edit`" class="px-3 py-1.5 text-sm text-gray-300 hover:text-white bg-gray-700/50 rounded-lg transition">
                            Edit
                        </Link>
                        <form :action="`/items/${item.id}`" method="post" class="inline" @submit="confirmDelete">
                            <input type="hidden" name="_token" :value="csrfToken">
                            <input type="hidden" name="_method" value="delete">
                            <button type="submit" class="px-3 py-1.5 text-sm text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-lg transition">
                                Delete
                            </button>
                        </form>
                    </div>
                </li>
            </ul>
        </main>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';
import { computed } from 'vue';

defineProps({
    items: Array,
});

const csrfToken = computed(() => document.querySelector('meta[name="csrf-token"]')?.getAttribute('content'));

function confirmDelete(e) {
    if (!confirm('Delete this item?')) e.preventDefault();
}
</script>
