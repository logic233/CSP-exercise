|      |                                        |                  |
| ---- | -------------------------------------- | ---------------- |
| CSP  | Communicating Sequential Processes     | 通信顺序进程     |
| TCP  | The Theory and Practice of Concurrency | 并发的理论和实践 |
| FDR  | Failures Divergences Refinement)       | 一个查错工具     |

## Chapter 1 构建一个简单的顺序进程

​		**一个CSP进程完全是靠它与外界通信的方式进行描述。**在构建一个进程时，我们首先需要决定一个alphabet——**一个包括了进程所有使用到的事件的集合**。有关这个alphabet的选择可能说是我们建模过程中最重要的部分。这一过程中我们使用的行为将决定细节等级、最终描述的抽象程度以及是否能得到一个合理的建模结果。但倘若我们要把这一切弄清楚，我们必须对基本符号有所掌握并且了解了一些例子。一些指导将在Sect1.5中提供。**所以，我们假设我们现在已经建立了alphabet，记为$\Sigma$。**

对于CSP模型中的通信，我们有以下基本假设：

- 它们是瞬间发生的。we abstract the real time intervals during which individual events are performed into single moments—conceptually the moments when an event becomes inevitable
- 它们只有在进程以及环境都运行的情况下才会发生。但是倘若进程与环境均满足时，它将在一定会在某一时刻发生。

​        CSP是使用通信模型对同环境有相互作用的进程进行设置与推理的。当然最重要的是，我们想要建立一个并发系统，其中的进程是可以彼此通信的。在这一章节中我们首先要了解一些基本操作符号，然后我们才能进行进程之间通信的描述。

### 1.1 基本操作符

#### 1.1.1Prefixing

最简单的CSP进程是一个啥也不做的进程，写作***STOP***，并且不会有任何通信。

a是$\Sigma$中的一个事件，P是一个进程,a → P 描述了一个进程，在开始的时候想要同a通信并且将无限期等待a的发生。在a发生后，这个进程将表现为P。这个进程之间的操作符（把P变为$a \to P$）is konwn as **prefixing**。

> Clearly STOP and prefixing, together, allow us to describe just the processes that
> make a fixed, finite sequence of communications before stopping. For example, 
>
> Day = getup→breakfast→work→lunch→play →dinner→tv→gotobed→STOP
> is a process describing someone’s day.

#### 1.1.2 Recursion

​         如果我们想要使用一个可以无限发生事件而不是快速停止的进程，我们可以使用**Recursion**。两种不同达到重复up、down效果的进程可以使用这样的方程式表示：

- P1 = up→down→P1
- P2 = up→down→up→down→P2

任何在等号右边进行递归定义的进程名字(P1,P2)将与整体一致。直觉上很明显，任何满足以上表达式的进程将均具备预期的行为。这种进行递归定义的形式是这样的，左边是一个代表整个进程的标识符，在右边则是一个可能包含标识符的过程术语。（如果右边没有出现标识符，那么这个进程就只是个简单的顺序进程）

此外我们还能同时定义以一种互递归的方式进行**Recursion**的定义。例如

- $P_u=up \to P_d$
- $P_d=down\to P_u$

其中$P_u$行为是和P1、P2相同的。

这本书中大部分循环将使用这种方程式定义，但是还有一种更简单的方式进行定义。μP.F(P) <==>P=F(P)  。例如

- $P=down\to up \to P$
  - $Q=up\to P$
  - $Q=up\to(μp.down\to up\to p)   (F(p)=down\to up\to p)$

> In fact the theories we explain in this book will allow us to prove that the three processes P1, P2 and Pu are equal. But that is a subject for later.

#### 1.1.3 Guarded Alternative

现在我们还是只能定义具有单一行为线程的进程，包括执行确定的有限行为或是无限的循环行为的进程。CSP提供很多方法来描述根据环境做选择的进程。从它们能表达的含义上来看，它们在很大程度是可以被交换的，之所以包含它们，是由于在编程中各自具有不同用途。

最简单的结构是这样的，一个包含不同行为和与之对应进程的列表，通过让环境选择其中**任意**事件来拓展前缀操作符，随后的行为是其对应的进程。

比如（$a_1\to P_1|...|a_n\to P_n $）

在第一步可以执行a1、...an中的任何事件，之后将表现事件对应的行为。

这种结构就称为 **Guarded Alternative**。

进程 $UandD = (up\to down\to STOP|down\to up\to STOP)$

能够按任意顺序执行这两个事件。

![uTools_1636110581832](\Understanding Concurrent Systems.assets\uTools_1636110581832.png)

将这个操作符同**recursion**结合使用，就可以表达一些复杂的行为了

- $P=(A\to P|b\to Q)$
- $Q=(a\to P|b\to STOP)$

此外，所谓有限状态机（一个有限状态的集合，每个都包含了一个有限的可用行为集合，根据行为确定其下一个状态）也就不难表示了。

可以定义一个有关计数器进程的系统

- $COUNT_0=UP\to COUNT_1$
- $COUNT_n=(UP\to COUNT_n+1|down\to COUNT_{n-1})(n>0)$

![uTools_1636112213349](\Understanding Concurrent Systems.assets\uTools_1636112213349.png)



$COUNT_n$是一个将传递任意up 和down行为序列的进程，只要当down的up差值不超过n+1。这些当然不算是有限状态机，因为根本上来说任何$COUNT_n$能够经过无数个状态。对于model checking来说，有限与无限的区别是至关重要的，这个术语经常被类似于FDR的状态监测工具所使用，因为该方法需要遍历所有状态。

$A\subseteq\Sigma,\forall x\in A$  都有一个进程P(x)

那么就有    $?x:A \to P(x)$

但凡是a是集合A中的元素，都会表现为进程P(X)

这种结构被称为**prefix-choice ** ，这种方式将 Guarded Alternative聚合了。

$?x:\varnothing \to P(x)\equiv STOP$

$?x:\{a\} \to P(x)\equiv a\to P(a)$

当P(x)对x的依赖主要是体现在构建后续通信时，例如构建循坏或类似行为时，可以使用这种运算符。因此我们可以有以下简化：

$Initialise =?n : \Bbb{N}\to COUNT_n$

在很多时候，拥有一个包含复合对象的$\Sigma$是很有用的，通常用中间的点表示。例如，c是一个”通道“的名字，T是通过它传递的对象的类型，那么就有$c.T=\{c.x|x\in T \}\subseteq\Sigma$

> It is natural to think of processes inputting and outputting values of type T over c:an inputting process would typically be able to communicate any element of c.T and an outputting process would only be able to communicate one.

$?y:c.T\to P(y)$，我们使用一种更加优雅的表达方式$c?x:T\to P^{\prime}(x)$                  

例如，COPY进程，在通道left输入T元素，然后在通道right输出它们，可以这样定义： $COPY=left?x:T\to right.x\to COPY$ 这是一个有关缓冲区进程的最简单的例子，期望能够将通道A上的输入序列，经过转换，输出到通道B中。

当我们想要允许任何元素可以通过通道c进行通信时，T集合可以被省略也就是说$c?x\to P(x)\equiv c?x:T\to P(x) $

在通常情况在 c!x可以被看为c.x的同义词，所以COPY进程也可以表示为$COPY=left?x:T\to right!x\to COPY$

> It is important to remember that, even though this syntax allows us to model
> input and output over channels, the fundamental CSP model of communication still applies: neither an input nor an output can occur until the environment allows it.

作为之前不相交假设的拓展，在guards中的所有的事件和输入通道都是不同的，并且每个事件都只属于一个通道。

例如，我们可以扩展人类主题的alphabet，使eats变成一个类型为{早餐、午餐、晚餐、零食}的通道，而tv则提供一系列的电视通道。

### 1.2 Choice Operator

#### 1.2.1 External Choice

$P\square Q$是一个进程，为环境提供了在PQ之间选择一个作为第一个事件的选择，之后进行相应的表现。因此 $(a\to Q)\square(b\to Q)\equiv(a\to Q|b\to Q)$

定律$P=P\square STOP$,因为为环境提供的P的动作和没有其他动作之间的选择是一样的。

非确定性进程：进程允许自己做出选择，从而影响外界表象，例如$(a\to a\to STOP)\square(a\to b\to STOP)$就是非确定的

#### 1.2.2 Nondeterministic Choice

非确定性一直存在于CSP中，所以要有适合的符号表示

$P\sqcap Q$ and $\sqcap S$    P和Q都是进程，S是非空的进程集合。

对于认识到$P\square Q$和$p\sqcap Q$之间的区别是很重要的。前者是由环境掌握的，后者则是由进程掌握的。

函数上看，进程P完全可以代替$P\sqcap Q$，因为我们是无法从外部阻止后者表现为P的。如果有$R=R\sqcap P$，我们可以说P更具有确定性性，或者说P提炼了R，记为$R\sqsubseteq P$。这给出了CSP进程中what is 'better' than another的观念。

 ![uTools_1636528978355](\Understanding Concurrent Systems.assets\uTools_1636528978355.png)

增加的STOP表示了缓冲区无法输入（满）的情况，更加符合实际。

#### 1.2.3 Conditional Choice

①$P\nless e\ngtr Q$    **if e then P else Q**  

$ABS=left?x\to right!((-x)\nless x<0\ngtr x)\to ABS$

②$e\&P$ **if e then P else STOP**    

#### 1.2.4 Multi-Part Events: Extending the Notation ofChannels

### 1.3 A Few Important Processed

$$
RUN_A=?x:A\to RUN_A\\
Chaos_A=STOP\sqcap(?x:A\to Chaos_A)
$$

$RUN_A$ : 环境总是能够同集合A中的任何成员通信

$Chaos_A$：进程总是能选择通信或者拒绝

### 1.4 Trances Refinement

最基础的记录发生了什么的方式，是把发生事件的事件的trace给写下来。所谓trace，就是在环境与进程之间的通信序列。

traces是一种我们用来构建CSP进程模型的典型行为。通过与环境之间的交互，它们是可以被清晰观测的，并且它们中的每一个都是一次独立交互的记录。这里介绍一种基础的方法，用来说明CSP进程的正确性。

![uTools_1637913669441](E:\我的坚果云\md\execrise\CSP\Understanding Concurrent Systems.assets\uTools_1637913669441.png)

Q trace-refines P（Q在迹上提炼了P）或者说，每个Q的迹都是P的迹。

在FDR中这种函数具有一种常见用法：P是一个迹的集合，这些迹是一个满足于某些规约的进程所能够允许的，Q则是一个我们想要测试的进程。

在这本书中，几乎所有我们想要证明的进程属性都能表示为某种提炼，虽然有时模型会更加丰富。绝大多数关于进程P的**属性**将会表示为$Spec\sqsubseteq  P$而不是模型，我们叫它们behavioural specifications，因其表达了每一个P的行为都在Spec中，但是提炼允许我们表示关于P的更加普遍的属性：$F(P)\sqsubseteq G(P)$是一种CPS定义的函数，或者成为上下文F,G。

CSP不仅是一种用来记录计划实施的语言，而且可以用来记录规范。所有，当使用CSP去描述系统时，通常不必使用第二种语言来描述规范。

### 1.5 What is a Communication?

CSP 是研究特定进程的演算，这些进程通过通信的方式同彼此或是环境进行交互。CSP中最基本的对象是通信事件。$\Sigma$通常被用来表示所有体系中所有可能发生的进程通信的集合。可以把通信同多个进程之间的转变、同步相类比，而不是被视为单向的数据传输。

CSP中的事件具备条件性（需要双边同意）和瞬时性。

只有当进程同环境发生通信时，环境才能观测它。

CSP会包含一些在“坏行为”（例如死锁、不确定性）的定义，是为了证明这些行为在实际程序中不存在。

### 1.6 Tools

帮助我们理解CSP进程的自动化工具主要有两大类：一是让我们直观地观察进程是如何表现的，二是尝试去证明一些属性，例如迹的提炼。

前者的例子就是PRoBE。通过该工具，你可以写下一个任意的进程描述以及它的交互。换而言之，你可以扮演环境。事实上，动画器提供了有关进程控制的各种程度选项（例如，进程有多少行为是自动的），通常它也会提供更加精确的控制方式。例如，你可以控制进程的内部选择。

在第8章中，会为FDR小白讲解FDR是什么以及使用方法。尤其是，会介绍CSP的ASCII版本，即$CSP_M$，可作为各类CSP工具的输入格式。以及对于FDR工具来说相当重要的，有限状态和无限状态的区别。

在$CSP_M$中明确使用的事件用下列方法进行明确定义：

```go
channel sleep,getup,gotobed
channel eat:Meals
channel tv:Channels
channel walk:Place.Place
```

第一行定义了无数据通道，命名为**独立事件**。剩下的皆定义了至少拥有一个数据组件的通道。所有$CSP_M$中的事件都由一个通道名以及0或多个数据组件组成。'channel'定义创造了一个在脚本可以使用的名字。

#### 1.6.1 Finite-State Machines

由于FDR是靠展开进程的状态空间来工作的，所以倘若进程是无限的，FDR将不会停下来！

一种解决这个问题的方法是限制参数数量。

## Chapter 2 Understanding CSP

该章将描述一些可以证明进程等价的方法以及理解进程是如何表现的。

关于CSP程序，有3种方法去理解它们。第一是algebra，我们设置规则确保记号满足它们；第二是behavioural models 例如迹，构成了提炼关系和其他东西的基础；第三是operational models，尝试去理解进程执行在运行过程中的所有行动和决定。

### 2.1 Algebra

代数法则就是两个表达式（包含操作符和标识符）等价。所谓等价，我们可以理解为两边是本质上相同的，对CSP来说就是他们的通信行为不能够被环境所区分。

CSP中我们讨论以下操作符：prefixing,external choice,nondeterministic choice,conditionals.

外部和内部选择均有幂等性、对称性、结合性。

![uTools_1638168514741](E:\我的坚果云\md\execrise\CSP\Understanding Concurrent Systems.assets\uTools_1638168514741.png)

这三种规则是我们确保集合非确定性选择符($\sqcap S$)成立的必须条件。

分配性

![uTools_1638169979003](E:\我的坚果云\md\execrise\CSP\Understanding Concurrent Systems.assets\uTools_1638169979003.png)

由于CSP是线性时间观察（无法冻结和回退），绝大多操作符对不确定事件的分配率都是正确的。但在其他进程代数中是不正确的。

分配律对于循环来说是不使用的。

在CSP中最常用的定律。

![uTools_1638237229696](E:\我的坚果云\md\execrise\CSP\Understanding Concurrent Systems.assets\uTools_1638237229696.png)

如果一个进程同时提供A和B，那么当A和B同时提供的时候，进程将进行内部选择。![uTools_1638237496191](E:\我的坚果云\md\execrise\CSP\Understanding Concurrent Systems.assets\uTools_1638237496191.png)

这被称为步进法则，因为它允许我们计算混合行为的第一个阶段。![uTools_1638237849465](Understanding Concurrent Systems.assets/uTools_1638237849465.png)

![uTools_1638237924141](Understanding Concurrent Systems.assets/uTools_1638237924141.png)

条件选择也是幂等和可分配的。![uTools_1638237995871](Understanding Concurrent Systems.assets/uTools_1638237995871.png)

![uTools_1638238065899](Understanding Concurrent Systems.assets/uTools_1638238065899.png)

![uTools_1638238080694](Understanding Concurrent Systems.assets/uTools_1638238080694.png)

![uTools_1638238094170](Understanding Concurrent Systems.assets/uTools_1638238094170-16382381122861.png)

### 2.2 The Traces Model and Traces Refinement

trace是我们能够观察到的动作序列，但是真正的发生时间是不会被记录的。事实证明，根据一个非时间CSP进程所有能表示trace的集合来建模是非常自然的。

#### 2.2.1 Working out teaces(P)

对于任何进程P来说，traces(P)是它所有有限迹的集合，是有限时间序列集合的成员。例如$traces(a\to b\to STOP)=\{<>,<a>,<a,b>\}$

序列不同于集合，其中元素的次序以及重复数量都是很重要的。

- <>表示一个空序列
- s^t表示序列的连接
- 如果s是一个初始子序列，或者是t的前缀，那么有t=s^w，我们可以记作$s\le t$

traces(P)的两大性质

- 非空性：traces(P)总是包含空迹<>
- 前缀封闭性prefix-closed：如果s^t是一个迹，那么在记录它的早些时候，s也是一个迹。

各类进程的traces均可以通过句法结构进行计算。

对于循环结构p=Q(Q是包含p的一个进程)。通过其他结构得到traces的方法意味着一个术语，就像是Q，通过一个自由进程标识符p，描绘了一个从迹集合到另一种迹集合的函数F。可以用X=F(X)来代表循环的迹。

倘若带有参数或是相互递归的情况将有些许不同，因为更高的通用性意味着更难以用公式阐述，这种情况下，我们有对一堆进程的定义，其中的任何一个都可以调用其他的。这种方法定义了一种进程名称向量。对于解决互相定义进程的迹问题就转换成了解决X=F(X),X是轨迹集的一个向量，而F是一个输入输出皆为轨迹集向量的函数。

![uTools_1638431190458](Understanding Concurrent Systems.assets/uTools_1638431190458.png)

#### 2.2.2 Traces and Laws

不管如何，进程在algebra或者是traces上的证明都是一致的。

#### 2.2.3 Unique Fixed Points

如果Z=F(Z)是一个由保护性递归构成的不动点方程，Y是一个进程（进程向量）满足于该方程，就有$X=_TY$另而言之，该方程拥有一个确定的解或者是向量。该原则被称为UFP.



#### 2.2.4 Specification and Refinement 
