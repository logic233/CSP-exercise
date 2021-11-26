##### Exercise 1.2  

A bank account is a process into which money can be deposited and from which it can be withdrawn. Define first a simple account ACCT0 which has events deposit and withdraw, and which is always prepared to communicate either.
$$
ACCT_0=deposit\to ACCT_0 \square withdraw\to ACCT_0
$$

##### Exercise 1.3

Now extend the alphabet to include open and close. ACCT1 behaves like ACCT0 except that it allows no event before it has been opened, and allows no further event after it has been closed (and is always prepared to accept close while open). You might find it helpful to define a process OPEN representing an open account.
$$
ACCT_2=open\to OPEN_0
\\\\
OPEN_t=deposit?x\to OPEN_{t+x}\square\\
withdraw?x\to OPEN_{t-x}\square\\
blance?x:0\to close\\
$$

##### Exercise 1.4

ACCT0 and ACCT1 have no concept of a balance. Introduce a parameter representing the balance of an OPEN account. The alphabet is open and close as before, deposit.N and withdraw.N (which have now become channels indicating the amount of the deposit or withdrawal) plus balance.Z (Z is the set of positive and negative integers), a channel that can be used to find out the current balance. An account has a zero balance when opened, and may only be closed when it has a zero balance. Define processes ACCT2 and ACCT3 which (respectively) allow any withdrawal and only allow those which would not overdraw the account (make the balance negative).










$$
CMC_n=in100\to CMC_{n+100}\vartriangleleft n<5\vartriangleright (out5\to CMC_{n-5}\\
\sqcap(n \geqslant 10\& out10\to CMC_{n-10})\\
\sqcap(n \geqslant 20\& out20\to CMC_{n-20})\\
$$



