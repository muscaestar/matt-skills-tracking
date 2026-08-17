---
name: codebase-design
description: 设计深模块的共享词汇。当用户想要设计或改进模块接口、寻找深化机会、决定接缝位置、让代码更可测试或对 AI 更易导航，或其他技能需要深模块词汇时使用。
commit_version: ee8bae40062cd6b435073368ed0c540f48c35862
---

# Codebase Design

设计**深模块（deep modules）**：把大量行为放在小接口后面，接口位于干净的接缝处，并能通过该接口测试。在任何设计或重构代码的地方，都使用这套语言和原则。目标是为调用方提供杠杆（leverage），为维护者提供局部性（locality），为所有人提供可测试性。

## 术语表

请严格使用这些术语——不要用 “component”、“service”、“API” 或 “boundary” 替代。语言一致正是全部意义所在。

**Module**——任何有接口和实现的东西。刻意与规模无关：函数、类、包，或横跨多层的切片。_避免使用_：unit、component、service。

**Interface**——调用方为了正确使用模块而必须知道的一切：类型签名，还有不变量、顺序约束、错误模式、必需配置和性能特征。_避免使用_：API、signature（太窄——它们只指类型层面的表面）。

**Implementation**——模块内部的东西，即其代码主体。与 **Adapter** 不同：一个东西可以是小 adapter 配大实现（Postgres repo），也可以是大 adapter 配小实现（内存 fake）。当话题是接缝时用 “adapter”，否则用 “implementation”。

**Depth**——接口处的杠杆：调用方（或测试）每学习一个单位接口，能行使多少行为。当大量行为位于小接口之后时，模块是**深（deep）**的；当接口几乎和实现一样复杂时，模块是**浅（shallow）**的。

**Seam** _(Michael Feathers)_——一个无需就地编辑就能改变行为的位置；即模块接口所处的*位置*。把接缝放在哪里本身是一项设计决策，与接缝后面放什么不同。_避免使用_：boundary（与 DDD 的限界上下文含义重叠）。

**Adapter**——在接缝处满足某个接口的具体事物。描述的是*角色*（它填充哪个槽位），而不是实质（里面是什么）。

**Leverage**——调用方从深度中得到的东西：每学习一个单位接口就能获得更多能力。一个实现可以在 N 个调用点和 M 个测试中反复回本。

**Locality**——维护者从深度中得到的东西：变更、bug、知识和验证集中在一处，而不是散布在调用方之间。修一次，处处修复。

## 深与浅

**深模块** = 小接口 + 大量实现：

```
┌─────────────────────┐
│   Small Interface   │  ← Few methods, simple params
├─────────────────────┤
│                     │
│  Deep Implementation│  ← Complex logic hidden
│                     │
└─────────────────────┘
```

**浅模块** = 大接口 + 很少实现（应避免）：

```
┌─────────────────────────────────┐
│       Large Interface           │  ← Many methods, complex params
├─────────────────────────────────┤
│  Thin Implementation            │  ← Just passes through
└─────────────────────────────────┘
```

设计接口时，问：

- 我能减少方法数量吗？
- 我能简化参数吗？
- 我能在内部隐藏更多复杂度吗？

## 原则

- **深度是接口的属性，而不是实现的属性。** 深模块内部可以由小型、可 mock、可替换的部件组成——它们只是不属于接口。一个模块可以既有**内部接缝**（对实现私有，供自己的测试使用），也有位于接口处的**外部接缝**。
- **删除测试。** 想象删除这个模块。如果复杂度随之消失，它只是个透传。如果复杂度在 N 个调用方处重新出现，它就在自食其力。
- **接口就是测试面。** 调用方和测试跨越同一条接缝。如果你想测到接口*之外*，模块的形状可能就错了。
- **一个 adapter 意味着假设性接缝，两个 adapter 才意味着真实接缝。** 除非确实有东西会跨接缝变化，否则不要引入接缝。

## 为可测试性而设计

好的接口让测试变得自然：

1. **接受依赖，不要创建依赖。**

   ```typescript
   // Testable
   function processOrder(order, paymentGateway) {}

   // Hard to test
   function processOrder(order) {
     const gateway = new StripeGateway();
   }
   ```

2. **返回结果，不要制造副作用。**

   ```typescript
   // Testable
   function calculateDiscount(cart): Discount {}

   // Hard to test
   function applyDiscount(cart): void {
     cart.total -= discount;
   }
   ```

3. **小表面积。** 方法越少，需要的测试越少。参数越少，测试准备越简单。

## 关系

- 一个 **Module** 恰好有一个 **Interface**（它呈现给调用方和测试的表面）。
- **Depth** 是 **Module** 的属性，对照其 **Interface** 衡量。
- **Seam** 是 **Module** 的 **Interface** 所在之处。
- **Adapter** 位于 **Seam** 处并满足 **Interface**。
- **Depth** 为调用方带来 **Leverage**，为维护者带来 **Locality**。

## 被否定的表述方式

- **把 Depth 当作实现行数与接口行数之比**（Ousterhout）：会奖励往实现里注水。我们改用“深度即杠杆”。
- **把 “Interface” 当作 TypeScript 的 `interface` 关键字或类的公开方法**：太窄——这里的接口包括调用方必须知道的每个事实。
- **“Boundary”**：与 DDD 的限界上下文含义重叠。请说 **seam** 或 **interface**。

## 进一步深入

- **在给定依赖的情况下深化一个簇**——见 [DEEPENING.md](DEEPENING.md)：依赖类别、接缝纪律，以及“替换而非分层”的测试方法。
- **探索替代接口**——见 [DESIGN-IT-TWICE.md](DESIGN-IT-TWICE.md)：启动并行子 agent，用几种截然不同的方式设计接口，然后从深度、局部性和接缝位置三个维度比较。
