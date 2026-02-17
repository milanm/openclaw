import { describe, test, expect } from 'vitest';
import { hello } from '../src/index.js';

describe('hello', () => {
  test('returns greeting with name', () => {
    expect(hello('World')).toBe('Hello, World!');
  });

  test('works with different names', () => {
    expect(hello('Alice')).toBe('Hello, Alice!');
    expect(hello('Bob')).toBe('Hello, Bob!');
  });
});
