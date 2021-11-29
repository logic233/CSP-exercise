##### Exercise 1.2  

A bank account is a process into which money can be deposited and from which it can be withdrawn. Define first a simple account ACCT0 which has events deposit and withdraw, and which is always prepared to communicate either.
$$
ACCT_0=deposit\to ACCT_0 \square withdraw\to ACCT_0
$$

##### Exercise 1.3

Now extend the alphabet to include open and close. ACCT1 behaves like ACCT0 except that it allows no event before it has been opened, and allows no further event after it has been closed (and is always prepared to accept close while open). You might find it helpful to define a process OPEN representing an open account.
$$
ACCT_1=open\to OPEN\\
OPEN=deposit\to OPEN|withdraw\to OPEN|close
$$

##### Exercise 1.4

ACCT0 and ACCT1 have no concept of a balance. Introduce a parameter representing the balance of an OPEN account. The alphabet is open and close as before, deposit.N and withdraw.N (which have now become channels indicating the amount of the deposit or withdrawal) plus balance.Z (Z is the set of positive and negative integers), a channel that can be used to find out the current balance. An account has a zero balance when opened, and may only be closed when it has a zero balance. Define processes ACCT2 and ACCT3 which (respectively) allow any withdrawal and only allow those which would not overdraw the account (make the balance negative).

$$
ACCT_2=open\to OPEN_0
\\\\
OPEN_t=deposit?x\to OPEN_{t+x}\square\\
withdraw?x\to OPEN_{t-x}\square\\
blance?x:0\to close\\
$$

$$
ACCT_3=open\to OPEN_0
\\\\
OPEN_t=deposit?x\to OPEN_{t+x}\square\\
withdraw?x\{y|y\in(0,t]\}\to OPEN_{t-x}\square\\
blance?x:0\to close\\
$$

##### Exercise 1.5

Extend the definition of COUNTn so that it also has the events up5, up10, down5 and down10 which change the value in the register by the obvious amounts, and are only possible when they do not take this value below zero.
$$
COUNT_n=up5\to COUNT_{n+5}\square\\
up10\to COUNT_{n+10}\square\\
n\ge 5\&down5\to COUNT_{n-5}\square\\
n\ge 10\&down10\to COUNT_{n-10}\square\\
$$

##### Exercise 1.6

A change-giving machine takes in £1 coins and gives change in 5, 10 and 20 pence coins. It should have the following events: in£1, out5p, out10p, out20p. Define versions with the following behaviours:
(a) CMA gives the environment the choice of how it wants the change, and if an extra £1 is inserted while it still has a non-zero balance it increases the amount of change available accordingly.
$$
CMA_n=in100\to CMC_{n+100}\vartriangleleft n<5\vartriangleright (out5\to CMC_{n-5}\\
\sqcap(n \geqslant 10\& out10\to CMC_{n-10})\\
\sqcap(n \geqslant 20\& out20\to CMC_{n-20})\\
$$
(b) CMB behaves like CMA except that it will only accept a further £1 if its balance is less than 20p.

(c) CMC is allowed to choose any correct combination of change nondeterministically, only allowing the insertion of £1 when it has zero balance.

$$
CMC_n=in100\to CMC_{n+100}\vartriangleleft n<5\vartriangleright (out5\to CMC_{n-5}\\
\sqcap(n \geqslant 10\& out10\to CMC_{n-10})\\
\sqcap(n \geqslant 20\& out20\to CMC_{n-20})\\
$$



