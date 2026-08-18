---
name: migrate-to-shoehorn
description: 把测试文件从 `as` 类型断言迁移到 @total-typescript/shoehorn。当用户提到 shoehorn、想替换测试中的 `as`，或需要部分测试数据时使用。
commit_version: 62f43a18177be6ec82da242e59ffbc490a4c22ea
---

# 迁移到 Shoehorn

## 为什么用 shoehorn？

`shoehorn` 让你在测试中传入部分数据的同时让 TypeScript 满意。它用类型安全的替代品替换 `as` 断言。

**仅限测试代码。** 永远不要在生产代码中使用 shoehorn。

测试中使用 `as` 的问题：

- 我们被训练成不要用它
- 必须手动指定目标类型
- 故意传错数据时需要双重断言（`as unknown as Type`）

## 安装

```bash
npm i @total-typescript/shoehorn
```

## 迁移模式

### 只需要少数属性的大对象

之前：

```ts
type Request = {
  body: { id: string };
  headers: Record<string, string>;
  cookies: Record<string, string>;
  // ...20 more properties
};

it("gets user by id", () => {
  // Only care about body.id but must fake entire Request
  getUser({
    body: { id: "123" },
    headers: {},
    cookies: {},
    // ...fake all 20 properties
  });
});
```

之后：

```ts
import { fromPartial } from "@total-typescript/shoehorn";

it("gets user by id", () => {
  getUser(
    fromPartial({
      body: { id: "123" },
    }),
  );
});
```

### `as Type` → `fromPartial()`

之前：

```ts
getUser({ body: { id: "123" } } as Request);
```

之后：

```ts
import { fromPartial } from "@total-typescript/shoehorn";

getUser(fromPartial({ body: { id: "123" } }));
```

### `as unknown as Type` → `fromAny()`

之前：

```ts
getUser({ body: { id: 123 } } as unknown as Request); // wrong type on purpose
```

之后：

```ts
import { fromAny } from "@total-typescript/shoehorn";

getUser(fromAny({ body: { id: 123 } }));
```

## 什么时候用哪个

| 函数            | 使用场景                                     |
| --------------- | -------------------------------------------- |
| `fromPartial()` | 传入仍能通过类型检查的部分数据               |
| `fromAny()`     | 传入故意错误的数据（保留自动补全）           |
| `fromExact()`   | 强制完整对象（之后可与 fromPartial 互换）    |

## 工作流程

1. **收集需求**——问用户：
   - 哪些测试文件有造成问题的 `as` 断言？
   - 他们是否在处理只有部分属性重要的大对象？
   - 他们是否需要为错误测试传入故意错误的数据？

2. **安装并迁移**：
   - [ ] 安装：`npm i @total-typescript/shoehorn`
   - [ ] 找出带 `as` 断言的测试文件：`grep -r " as [A-Z]" --include="*.test.ts" --include="*.spec.ts"`
   - [ ] 把 `as Type` 替换为 `fromPartial()`
   - [ ] 把 `as unknown as Type` 替换为 `fromAny()`
   - [ ] 添加来自 `@total-typescript/shoehorn` 的 import
   - [ ] 运行类型检查验证
