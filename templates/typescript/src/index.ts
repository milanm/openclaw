export function hello(name: string): string {
  return `Hello, ${name}!`;
}

// Example: Main entry point
if (import.meta.url === `file://${process.argv[1]}`) {
  console.log(hello('World'));
}
