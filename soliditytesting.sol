

// checking values
expect(await myContract.value()).to.equal(42);

//checking for reverts
 await expect(myContract.connect(user).restrictedFunction()).to.be.revertedWith("unauthorized")

//without a specific reason
await expect (myContract.connect(user).restrictedFunction()).to.be.reverted;

//checking events (checking if an event emitted)
await expect(myContract.doSomething(123)).to.emit(myContract, "valueChanged").withArgs(123);

//comparing bigNumbers
expect(await myContract.balanceOf(user.address)).to.equal(ethers.parseEther("1"));


