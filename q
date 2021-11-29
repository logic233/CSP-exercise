[1mdiff --git a/Understanding Concurrent Systems.md b/Understanding Concurrent Systems.md[m
[1mindex 941032c..d715ae8 100644[m
[1m--- a/Understanding Concurrent Systems.md[m	
[1m+++ b/Understanding Concurrent Systems.md[m	
[36m@@ -175,7 +175,7 @@[m [m$Chaos_A$：进程总是能选择通信或者拒绝[m
 [m
 traces是一种我们用来构建CSP进程模型的典型行为。通过与环境之间的交互，它们是可以被清晰观测的，并且它们中的每一个都是一次独立交互的记录。这里介绍一种基础的方法，用来说明CSP进程的正确性。[m
 [m
[31m-![uTools_1637913669441](\Understanding Concurrent Systems.assets\uTools_1637913669441.png)[m
[32m+[m[32m![uTools_1637913669441](E:\我的坚果云\md\execrise\CSP\Understanding Concurrent Systems.assets\uTools_1637913669441.png)[m
 [m
 Q trace-refines P（Q在迹上提炼了P）或者说，每个Q的迹都是P的迹。[m
 [m
[36m@@ -189,7 +189,57 @@[m [mCSP不仅是一种用来记录计划实施的语言，而且可以用来记录[m
 [m
 CSP 是研究特定进程的演算，这些进程通过通信的方式同彼此或是环境进行交互。CSP中最基本的对象是通信事件。$\Sigma$通常被用来表示所有体系中所有可能发生的进程通信的集合。可以把通信同多个进程之间的转变、同步相类比，而不是被视为单向的数据传输。[m
 [m
[31m-CSP中的事件具备条件性和瞬时性。[m
[32m+[m[32mCSP中的事件具备条件性（需要双边同意）和瞬时性。[m
 [m
[32m+[m[32m只有当进程同环境发生通信时，环境才能观测它。[m
 [m
[32m+[m[32mCSP会包含一些在“坏行为”（例如死锁、不确定性）的定义，是为了证明这些行为在实际程序中不存在。[m
 [m
[32m+[m[32m### 1.6 Tools[m
[32m+[m
[32m+[m[32m帮助我们理解CSP进程的自动化工具主要有两大类：一是让我们直观地观察进程是如何表现的，二是尝试去证明一些属性，例如迹的提炼。[m
[32m+[m
[32m+[m[32m前者的例子就是PRoBE。通过该工具，你可以写下一个任意的进程描述以及它的交互。换而言之，你可以扮演环境。事实上，动画器提供了有关进程控制的各种程度选项（例如，进程有多少行为是自动的），通常它也会提供更加精确的控制方式。例如，你可以控制进程的内部选择。[m
[32m+[m
[32m+[m[32m在第8章中，会为FDR小白讲解FDR是什么以及使用方法。尤其是，会介绍CSP的ASCII版本，即$CSP_M$，可作为各类CSP工具的输入格式。以及对于FDR工具来说相当重要的，有限状态和无限状态的区别。[m
[32m+[m
[32m+[m[32m在$CSP_M$中明确使用的事件用下列方法进行明确定义：[m
[32m+[m
[32m+[m[32m```go[m
[32m+[m[32mchannel sleep,getup,gotobed[m
[32m+[m[32mchannel eat:Meals[m
[32m+[m[32mchannel tv:Channels[m
[32m+[m[32mchannel walk:Place.Place[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32m第一行定义了无数据通道，命名为**独立事件**。剩下的皆定义了至少拥有一个数据组件的通道。所有$CSP_M$中的事件都由一个通道名以及0或多个数据组件组成。'channel'定义创造了一个在脚本可以使用的名字。[m
[32m+[m
[32m+[m[32m#### 1.6.1 Finite-State Machines[m
[32m+[m
[32m+[m[32m由于FDR是靠展开进程的状态空间来工作的，所以倘若进程是无限的，FDR将不会停下来！[m
[32m+[m
[32m+[m[32m一种解决这个问题的方法是限制参数数量。[m
[32m+[m
[32m+[m[32m## Chapter 2 Understanding CSP[m
[32m+[m
[32m+[m[32m该章将描述一些可以证明进程等价的方法以及理解进程是如何表现的。[m
[32m+[m
[32m+[m[32m关于CSP程序，有3种方法去理解它们。第一是algebra，我们设置规则确保记号满足它们；第二是behavioural models 例如迹，构成了提炼关系和其他东西的基础；第三是operational models，尝试去理解进程执行在运行过程中的所有行动和决定。[m
[32m+[m
[32m+[m[32m### 2.1 Algebra[m
[32m+[m
[32m+[m[32m代数法则就是两个表达式（包含操作符和标识符）等价。所谓等价，我们可以理解为两边是本质上相同的，对CSP来说就是他们的通信行为不能够被环境所区分。[m
[32m+[m
[32m+[m[32mCSP中我们讨论以下操作符：prefixing,external choice,nondeterministic choice,conditionals.[m
[32m+[m
[32m+[m[32m外部和内部选择均有幂等性、对称性、结合性。[m
[32m+[m
[32m+[m[32m![uTools_1638168514741](E:\我的坚果云\md\execrise\CSP\Understanding Concurrent Systems.assets\uTools_1638168514741.png)[m
[32m+[m
[32m+[m[32m这三种规则是我们确保集合非确定性选择符($\sqcap S$)成立的必须条件。[m
[32m+[m
[32m+[m[32m分配性[m
[32m+[m
[32m+[m[32m![uTools_1638169979003](E:\我的坚果云\md\execrise\CSP\Understanding Concurrent Systems.assets\uTools_1638169979003.png)[m
[32m+[m
[32m+[m[32m由于CSP是线性时间观察（无法冻结和回退），绝大多操作符对不确定事件的分配率都是正确的。但在其他进程代数中是不正确的。[m
[1mdiff --git a/exercise.md b/exercise.md[m
[1mindex 6337ee8..b4a9cdb 100644[m
[1m--- a/exercise.md[m
[1m+++ b/exercise.md[m
[36m@@ -9,25 +9,52 @@[m [m$$[m
 [m
 Now extend the alphabet to include open and close. ACCT1 behaves like ACCT0 except that it allows no event before it has been opened, and allows no further event after it has been closed (and is always prepared to accept close while open). You might find it helpful to define a process OPEN representing an open account.[m
 $$[m
[31m-ACCT_2=open\to OPEN_0[m
[31m-\\\\[m
[31m-OPEN_t=deposit?x\to OPEN_{t+x}\square\\[m
[31m-withdraw?x\to OPEN_{t-x}\square\\[m
[31m-blance?x:0\to close\\[m
[32m+[m[32mACCT_1=open\to OPEN\\[m
[32m+[m[32mOPEN=deposit\to OPEN|withdraw\to OPEN|close[m
 $$[m
 [m
 ##### Exercise 1.4[m
 [m
 ACCT0 and ACCT1 have no concept of a balance. Introduce a parameter representing the balance of an OPEN account. The alphabet is open and close as before, deposit.N and withdraw.N (which have now become channels indicating the amount of the deposit or withdrawal) plus balance.Z (Z is the set of positive and negative integers), a channel that can be used to find out the current balance. An account has a zero balance when opened, and may only be closed when it has a zero balance. Define processes ACCT2 and ACCT3 which (respectively) allow any withdrawal and only allow those which would not overdraw the account (make the balance negative).[m
 [m
[32m+[m[32m$$[m
[32m+[m[32mACCT_2=open\to OPEN_0[m
[32m+[m[32m\\\\[m
[32m+[m[32mOPEN_t=deposit?x\to OPEN_{t+x}\square\\[m
[32m+[m[32mwithdraw?x\to OPEN_{t-x}\square\\[m
[32m+[m[32mblance?x:0\to close\\[m
[32m+[m[32m$$[m
 [m
[32m+[m[32m$$[m
[32m+[m[32mACCT_3=open\to OPEN_0[m
[32m+[m[32m\\\\[m
[32m+[m[32mOPEN_t=deposit?x\to OPEN_{t+x}\square\\[m
[32m+[m[32mwithdraw?x\{y|y\in(0,t]\}\to OPEN_{t-x}\square\\[m
[32m+[m[32mblance?x:0\to close\\[m
[32m+[m[32m$$[m
 [m
[32m+[m[32m##### Exercise 1.5[m
 [m
[32m+[m[32mExtend the definition of COUNTn so that it also has the events up5, up10, down5 and down10 which change the value in the register by the obvious amounts, and are only possible when they do not take this value below zero.[m
[32m+[m[32m$$[m
[32m+[m[32mCOUNT_n=up5\to COUNT_{n+5}\square\\[m
[32m+[m[32mup10\to COUNT_{n+10}\square\\[m
[32m+[m[32mn\ge 5\&down5\to COUNT_{n-5}\square\\[m
[32m+[m[32mn\ge 10\&down10\to COUNT_{n-10}\square\\[m
[32m+[m[32m$$[m
 [m
[32m+[m[32m##### Exercise 1.6[m
 [m
[32m+[m[32mA change-giving machine takes in £1 coins and gives change in 5, 10 and 20 pence coins. It should have the following events: in£1, out5p, out10p, out20p. Define versions with the following behaviours:[m
[32m+[m[32m(a) CMA gives the environment the choice of how it wants the change, and if an extra £1 is inserted while it still has a non-zero balance it increases the amount of change available accordingly.[m
[32m+[m[32m$$[m
[32m+[m[32mCMA_n=in100\to CMC_{n+100}\vartriangleleft n<5\vartriangleright (out5\to CMC_{n-5}\\[m
[32m+[m[32m\sqcap(n \geqslant 10\& out10\to CMC_{n-10})\\[m
[32m+[m[32m\sqcap(n \geqslant 20\& out20\to CMC_{n-20})\\[m
[32m+[m[32m$$[m
[32m+[m[32m(b) CMB behaves like CMA except that it will only accept a further £1 if its balance is less than 20p.[m
 [m
[31m-[m
[31m-[m
[32m+[m[32m(c) CMC is allowed to choose any correct combination of change nondeterministically, only allowing the insertion of £1 when it has zero balance.[m
 [m
 $$[m
 CMC_n=in100\to CMC_{n+100}\vartriangleleft n<5\vartriangleright (out5\to CMC_{n-5}\\[m
