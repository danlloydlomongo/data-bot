<template>
    <div class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 flex flex-col">
        <!-- Header -->
        <header class="border-b border-gray-700/50">
            <div class="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
                <div class="flex items-center gap-3">
                    <div class="w-10 h-10 bg-indigo-500 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                        </svg>
                    </div>
                    <span class="text-xl font-bold text-white">Data Bot</span>
                </div>
                <nav class="flex items-center gap-4">
                    <a href="/items" class="text-sm text-gray-300 hover:text-white transition">Items</a>
                    <a href="#features" class="text-sm text-gray-300 hover:text-white transition">Features</a>
                    <a href="#stack" class="text-sm text-gray-300 hover:text-white transition">Stack</a>
                </nav>
            </div>
        </header>

        <!-- Hero -->
        <main class="flex-1 flex items-center justify-center px-6">
            <div class="max-w-3xl mx-auto text-center">
                <div class="inline-flex items-center gap-2 bg-indigo-500/10 border border-indigo-500/20 rounded-full px-4 py-1.5 mb-8">
                    <span class="w-2 h-2 bg-green-400 rounded-full animate-pulse"></span>
                    <span class="text-sm text-indigo-300">System Online</span>
                </div>

                <h1 class="text-5xl sm:text-6xl font-extrabold text-white tracking-tight mb-6">
                    Your Intelligent
                    <span class="bg-gradient-to-r from-indigo-400 to-cyan-400 bg-clip-text text-transparent">Data Assistant</span>
                </h1>

                <p class="text-lg text-gray-400 max-w-2xl mx-auto mb-10 leading-relaxed">
                    Data Bot helps you collect, process, and analyze data with an AI-powered pipeline.
                    Built with Laravel, Vue.js, and FastAPI.
                </p>

                <div class="flex flex-col sm:flex-row items-center justify-center gap-4">
                    <a href="#features" class="w-full sm:w-auto px-8 py-3 bg-indigo-500 hover:bg-indigo-400 text-white font-semibold rounded-lg transition shadow-lg shadow-indigo-500/25">
                        Get Started
                    </a>
                    <a href="#stack" class="w-full sm:w-auto px-8 py-3 bg-gray-800 hover:bg-gray-700 text-gray-200 font-semibold rounded-lg transition border border-gray-700">
                        View Stack
                    </a>
                </div>
            </div>
        </main>

        <!-- Features -->
        <section id="features" class="border-t border-gray-700/50 bg-gray-900/50 py-20 px-6">
            <div class="max-w-6xl mx-auto">
                <h2 class="text-3xl font-bold text-white text-center mb-12">Core Features</h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="bg-gray-800/50 border border-gray-700/50 rounded-xl p-6 hover:border-indigo-500/30 transition">
                        <div class="w-12 h-12 bg-indigo-500/10 rounded-lg flex items-center justify-center mb-4">
                            <svg class="w-6 h-6 text-indigo-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.582 4 8 4s8-1.79 8-4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4m0 5c0 2.21-3.582 4-8 4s-8-1.79-8-4" />
                            </svg>
                        </div>
                        <h3 class="text-lg font-semibold text-white mb-2">Data Collection</h3>
                        <p class="text-gray-400 text-sm leading-relaxed">Ingest data from multiple sources with automated pipelines and real-time processing.</p>
                    </div>

                    <div class="bg-gray-800/50 border border-gray-700/50 rounded-xl p-6 hover:border-indigo-500/30 transition">
                        <div class="w-12 h-12 bg-cyan-500/10 rounded-lg flex items-center justify-center mb-4">
                            <svg class="w-6 h-6 text-cyan-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                            </svg>
                        </div>
                        <h3 class="text-lg font-semibold text-white mb-2">AI Processing</h3>
                        <p class="text-gray-400 text-sm leading-relaxed">FastAPI-powered ML backend for intelligent data analysis and pattern recognition.</p>
                    </div>

                    <div class="bg-gray-800/50 border border-gray-700/50 rounded-xl p-6 hover:border-indigo-500/30 transition">
                        <div class="w-12 h-12 bg-emerald-500/10 rounded-lg flex items-center justify-center mb-4">
                            <svg class="w-6 h-6 text-emerald-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M13 10V3L4 14h7v7l9-11h-7z" />
                            </svg>
                        </div>
                        <h3 class="text-lg font-semibold text-white mb-2">Real-Time Updates</h3>
                        <p class="text-gray-400 text-sm leading-relaxed">WebSocket-driven live updates via Soketi for instant data synchronization.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Stack -->
        <section id="stack" class="border-t border-gray-700/50 py-20 px-6">
            <div class="max-w-4xl mx-auto text-center">
                <h2 class="text-3xl font-bold text-white mb-12">Built With</h2>
                <div class="flex flex-wrap justify-center gap-4">
                    <span v-for="tech in stack" :key="tech" class="px-4 py-2 bg-gray-800 border border-gray-700 rounded-lg text-sm text-gray-300">
                        {{ tech }}
                    </span>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="border-t border-gray-700/50 py-6 px-6">
            <div class="max-w-7xl mx-auto text-center text-sm text-gray-500">
                &copy; {{ new Date().getFullYear() }} Data Bot. Built with Laravel, Vue.js &amp; FastAPI.
            </div>
        </footer>
    </div>
</template>

<script setup>
const stack = [
    'Laravel 12',
    'Vue.js 3',
    'Inertia.js',
    'Tailwind CSS 4',
    'FastAPI',
    'MariaDB',
    'MongoDB',
    'Redis',
    'Soketi',
    'Traefik',
    'Docker',
    'Vite',
];
</script>

