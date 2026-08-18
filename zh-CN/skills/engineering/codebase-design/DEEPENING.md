# 深化

如何在给定依赖的情况下，安全地深化一簇浅模块。假定你已掌握 [SKILL.md](SKILL.md) 中的词汇——**module**、**interface**、**seam**、**adapter**。

## 依赖类别

评估深化候选时，先对其依赖分类。类别决定深化后的模块如何跨 seam 进行测试。

### 1. 进程内

纯计算、内存状态、无 I/O。始终可以深化——合并模块，直接通过新接口测试。不需要 adapter。

### 2. 本地可替换

有本地测试替身的依赖（用 PGLite 替 Postgres、内存文件系统）。如果替身存在，就可以深化。深化后的模块在测试套件中以运行着的替身进行测试。seam 是内部的；模块外部接口处没有端口。

### 3. 远程但自有（端口与适配器）

跨越网络边界的自有服务（微服务、内部 API）。在 seam 处定义一个**端口（port）**（接口）。深模块拥有逻辑；传输层作为 **adapter** 注入。测试使用内存 adapter，生产使用 HTTP/gRPC/队列 adapter。

推荐措辞：*“在 seam 处定义一个端口，为生产实现 HTTP adapter，为测试实现内存 adapter，这样即使逻辑部署在网络各处，也仍然位于一个深模块中。”*

### 4. 真正外部（Mock）

你无法控制的第三方服务（Stripe、Twilio 等）。深化后的模块把外部依赖作为注入的端口接收；测试提供一个 mock adapter。

## seam 纪律

- **One adapter means a hypothetical seam. Two adapters means a real one.（一个 adapter 意味着假设性 seam，两个 adapter 才意味着真实 seam。）** 除非至少两个 adapter 有存在理由（通常是生产 + 测试），否则不要引入端口。单 adapter 的 seam 只是间接层。
- **Internal seams 与 external seam（内部 seam 与外部 seam）。** 深模块可以有 internal seams（对实现私有，供自己的测试使用），也可以有位于接口处的 external seam。不要因为测试用到 internal seams，就把它们暴露到接口上。

## 测试策略：替换，而非分层

- 深化模块接口上的测试一旦存在，浅模块上旧的单元测试就成了废料——删掉它们。
- 在深化模块的接口上写新测试。**The interface is the test surface（接口就是测试面）。**
- 测试通过接口断言可观察的结果，而不是内部状态。
- 测试应当能经受内部重构——它们描述行为，而不是实现。如果测试必须随实现改变而改变，它就测到了接口之外。
