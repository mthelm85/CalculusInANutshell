### A Pluto.jl notebook ###
# v0.12.6

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ c2ad8940-1a0a-11eb-38de-7d2feb4c0fba
begin
	using Pkg
	Pkg.add(["LaTeXStrings","Plots","PlutoUI"])
	using LaTeXStrings
	using Plots
	using PlutoUI
	plotly()
end;

# ╔═╡ 00becd22-19ed-11eb-1be5-a1380e1f3e51
md"""
# Calculus in a Nutshell

#### I. Limits & Continuity

From *Wikipedia*:
> In mathematics, a limit is the value that a function (or sequence) "approaches" as the input (or index) "approaches" some value. Limits are essential to calculus and mathematical analysis, and are used to define continuity, derivatives, and integrals.

Let's dive right in and start with a couple of discontinous functions:
"""

# ╔═╡ 41505bfe-1a0b-11eb-2f7c-592c4b5aa816
plot(
	[1,1,1.9,2,2,2,2.9,3,3,3.9,3.9],
	[1,1,1,missing,2,2,2,missing,3,3,3],
	legend=false,
	marker=:dot,
	title="Discontinous Function #1",
	xlabel="x",
	ylabel="y"
)

# ╔═╡ f737c88e-1a0c-11eb-1b2e-95d746db7001
md"
The above function is equal to **1.0** over the range of **1.0 - 1.9**; it is equal to **2.0** over the range of **2.0 - 2.9**; and it is equal to **3.0** over the range of **3.0 - 3.9**. There are discontinuities in the function between **1.9 and 2.0** and between **2.9 and 3.0**.

Ask yourself the following question: **what is the value of this function as $x$ approaches 2.0 from the left-hand side? In other words, as you get closer and closer to the $x$ value of 2.0, what is the $y$ value?**

The answer to the above question is **1.0**. What if we asked the question but approach **2.0** from the right-hand side? The answer in that case is that the value of $y$ equals **2.0** as we approach an $x$ value of **2.0** from the right.

Let's write the above two statements in mathematical notation:

$\lim_{x \rightarrow 2^{-}} f(x) = 1.0$

$\lim_{x \rightarrow 2^{+}} f(x) = 2.0$

We use a $-$ sign to indicate an approach from the left and a $+$ sign to denote an approach from the right. You can see that we have a bit of a problem here: the two limits (approaching from the left and again from the right) are not equal. This means that $\lim_{x \rightarrow 2} f(x)$ doesn't exist! **The limit must be the same when approaching from the left and from the right in order for it to be an actual limit.**

Finally, let's determine the value of $f(2)$. We can see graphically that $f(2) = 2.0$. So,

$\lim_{x \rightarrow 2^{-}} f(x) \ne \lim_{x \rightarrow 2^{+}} f(x)$

and

$\lim_{x \rightarrow 2^{-}} f(x) \ne f(2)$
"

# ╔═╡ 3c3f4040-1a0c-11eb-24d6-47e1ede493be
plot(
	-2:0.1:2,
	vcat([-x^2 + 2 for x in -2:0.1:-0.1], [missing], [-x^2 + 2 for x in 0.1:0.1:2]),
	legend=false,
	title="Discontinous Function #2",
	ylims=(-2,3),
	marker=:dot,
	xlabel="x",
	ylabel="y"
)

# ╔═╡ c37f9460-1a0c-11eb-118b-eff09c826386
md"
Review the following:

$\lim_{x \rightarrow 0^{-}} f(x) = 2.0$

$\lim_{x \rightarrow 0^{+}} f(x) = 2.0$

Therefore, 

$\lim_{x \rightarrow 0} f(x) = 2.0$

However, 

$\lim_{x \rightarrow 0} f(x) \ne f(0)$

Note that $f(0)$ is undefined because the function is not continuous. With this, **we can now write a formal definition of continuity!** A function is said to be *continuous* when 

$\lim_{x \rightarrow a} f(x) = f(a)$

The below graph makes this clear:
"

# ╔═╡ 14db6c30-1a12-11eb-2f49-57902f4201ce
begin
	plot(
		-2:0.1:2,
		x -> -x^2 + 2,
		legend=false,
		title="A Continuous Function",
		ylims=(-2,3),
		marker=:dot,
		xlabel="x",
		ylabel="y"
	)
end

# ╔═╡ d92116ce-1a12-11eb-1cc5-93ef876a4ec7
md"
$\lim_{x \rightarrow 0} f(x) = f(0) = 2.0$
"

# ╔═╡ c19c9f60-1a13-11eb-3cb2-bd2f5f1094a1
md"""
#### II. Derivatives

From *Wikipedia*

> The derivative of a function of a real variable measures the sensitivity to change of the function value (output value) with respect to a change in its argument (input value).

Another way to state this is that the derivative of a function simply measures the rate of change of the function output compared to the function input at a particular instant or point. Let's define our continuous function above and see what this really means:

$f(x) = -x^{2} + 2$

Plotting this function yields the same plot, but this time I've removed the markers (dots):
"""

# ╔═╡ 01b77a60-1ab0-11eb-3ca3-81f2678f996f
plot(-2:0.1:2, x -> -x^2 + 2, legend=false, xlabel="x", ylabel="y", ylims=(-2,3))

# ╔═╡ 518885c0-1ab0-11eb-3b37-85d95934e7d0
md"""
At $x = -1$, what is happening with this function? What about at $x = 1$? If we think about this function as a map of the trajectory of a cannonball, we might say that at $x = -1$ the ball is moving upward and at $x = 1$ it is falling. Let's look at the derivative of this function at those two points by simply drawing trangent lines at those points and measuring their slopes. You can draw a tangent line to the curve with the slider below:
"""

# ╔═╡ dcf9b250-1ab0-11eb-2eb2-d5edd2ac615f
@bind xpoint Slider(-2:0.1:2, default=-1)

# ╔═╡ 424e5910-1ad1-11eb-14b6-a11fc2174312
md" x-value: $xpoint"

# ╔═╡ 000e7392-1ad7-11eb-3d1f-0f0e6e2d65b0
begin
	plot(-2:0.1:2, x -> -x^2 + 2, legend=false, xlabel="x", ylabel="y", ylims=(-2,3))
	plot!(
		-2:0.1:2,
		x -> -2xpoint*x + (-(-2xpoint)*xpoint + -xpoint^2 + 2), ylims=(-2,3),
		title = "f'(x) = $(-2xpoint)"
	)
end

# ╔═╡ 87683a90-1ac0-11eb-1386-81a04204732d
md"""
You can see that the slope of the line at $x = -1$ is 2 and at $x = 1$ it is -2. This makes sense in the context of the cannonball example as the cannonball is traveling upward at a rate of 2 units at $x = -1$ and it's falling at a rate of 2 units at $x = 1$.

Conceptually, derivatives are quite simple. But, how do we calculate them? This is where the concept of *limits* that we learned above comes in.

First, let's draw a secant line between two points on the curve. The first point will be at $x = -1$, the point at which we'd like to compute the derivative, and the second point will be chosen arbitrarily with the slider. A secant line will be drawn between the two points.
"""

# ╔═╡ d0233c20-1bb6-11eb-275c-ada04f429863
@bind xpoint1 Slider(-2:0.1:2, default=0)

# ╔═╡ db9e13e0-1bb6-11eb-34f5-ef1489135b5c
md" second point: $xpoint1"

# ╔═╡ e8837820-1bb6-11eb-1fd2-db9fa55aa429
begin
	f(x) = -x^2 + 2
	plot(-2:0.1:2, x -> -x^2 + 2, legend=false, xlabel="x", ylabel="y", ylims=(-2,3))
	scatter!([-1, xpoint1], [1, -xpoint1^2 + 2])
	plot!(
		-2:0.1:2,
		x -> ((f(xpoint1) - 1)/(xpoint1 + 1) * x) + (f(xpoint1) - 1)/(xpoint1 + 1)+1
	)
	plot!(
		-2:0.1:2,
		x -> 2x + 3, ylims=(-2,3)
	)
end

# ╔═╡ 61c3a1d2-1bba-11eb-1b47-51d874ac5c93
md"""
I've left the tangent line on the graph for a reason. Notice what happens when the distance between the two $x$ values gets smaller and smaller. The secant line gets closer and closer to the tangent line. When both $x$ values equal -1, the secant line goes away and all we see is the tangent line. In other words, as the difference between our two $x$ values approaches zero, the slope of our secant line approaches the slope of our tangent line. Since we know that the slope of the tangent line is the derivative, we can say that the slope of the secant line approaches the derivative of $f(x)$ as the distance between our two $x$ values approaches zero. Let's write that out mathematically.

First, we'll call the first $x$ value (at -1) $x$ and the second $x$ value $x_{1}$. The slope of the secant line is, as for any other line, the rise over run. To evaluate the rise, we simply evaluate our function $f$ at $x_{1}$ and at $x$, take the difference between the two values, and divide by the run which is simply $x_{1} - x$. So, the slope of the secant line is:

$\frac{f(x_{1}) - f(x)}{x_{1} - x}$

To compute the derivative, though, we need to take the *limit* of this function, where the difference between $x_{1}$ and $x$ approaches zero. Let's use $Δx$ ("delta x") to denote the difference between $x_{1}$ and $x$ and then we can write our limit as:

$\lim_{Δx \rightarrow 0} \frac{f(x + Δx) - f(x)}{Δx}$

This is indeed the derivative of this function! That's right, the derivative is a limit!! 😃

For our function $f(x) = -x^{2} + 2$, its derivative with respect to the variable $x$ can be written as:

$\frac{df}{dx} = \lim_{Δx \rightarrow 0} \frac{f(x + Δx) - f(x)}{Δx} = -2x$


"""

# ╔═╡ 4f677ace-1bbe-11eb-24e3-8fe0c488a721
md"""
#### III. Integrals

From *Wikipedia*

> In mathematics, an integral assigns numbers to functions in a way that can describe displacement, area, volume, and other concepts that arise by combining infinitesimal data. Integration is one of the two main operations of calculus; its inverse operation, differentiation, is the other. Given a function $f$ of a real variable $x$ and an interval $[a, b]$ of the real line, the definite integral of $f$ from $a$ to $b$ can be interpreted informally as the signed area of the region in the xy-plane that is bounded by the graph of $f$, the x-axis and the vertical lines $x = a$ and $x = b$.

Let's look at an example to make this more concrete. The definite integral of the function below from 0 to 2 is represented by the shaded region:
"""

# ╔═╡ 0c72cd50-1d0e-11eb-10ac-a7639ab2c207
begin
	plot(-2:0.1:2, x -> sin(x), legend=false, framestyle=:origin, xlabel="x", ylabel="y")
	plot!(0:0.1:2, x -> sin(x), lw=0, fill=(0, 0.25, :green))
end

# ╔═╡ 188c1280-1d0f-11eb-0769-83cbdbd0fc35
md"""
We can see that this is simply the area under the curve and above the x axis, between 0 and 2. How would we compute such an area? We can't simply multiply the height by the width as we would do for a rectangle. One option would be to approximate the area by drawing rectangles under the curve between 0 and 2 and summing their areas. Let's start by drawing a few rectangles under the curve and inspecting visually how well this approximation would do. Slowly increase the number of rectangles by sliding the slider to the left.
"""

# ╔═╡ 3494aa90-1ca2-11eb-39d1-bbeb7de9a2b0
@bind numbars Slider(0.025:0.025:0.5, default=0.5)

# ╔═╡ d3c490d0-1c9d-11eb-3384-5103402ef11e
begin
	plot(-2:0.1:2, x -> sin(x), legend=false)
	bar!(0+numbars/2:numbars:2+numbars/2, [sin(x) for x in 0:numbars:2], bar_width=numbars, alpha=0.5, xlims=(-2,2.2), framestyle=:origin, fill=(0, 0.25, :green))
end

# ╔═╡ 648e6200-1d64-11eb-009c-fb526f61ad14
md"""
It should be apparent that, as you increase the number of rectangles, the sum of their areas gets closer and closer to the area of the green-shaded region in the previous graph. In other words, as the number of rectangles approaches infinity, the sum of their areas approaches the actual area under the curve that we are trying to measure. 

So, how do we compute this? First, let's look at the notation and then it will become clear:

$\int_a^b \! f(x) \, \mathrm{d}x$

The way to read this is that we want to compute the integral of our function $f(x)$ from $a$ to $b$, and that we are integrating with respect to the  variable $x$. Let's break this down further. The $\int$ symbol is used to indicate that we need to take a sum of some infinitesimally small values. The $a$ and $b$ simply denote the lower and upper bounds of our interval. $f(x)$ is obviously the function that we are integrating and $\mathrm{d}x$ can be understood as the "delta x," just like with derivatives. It represents an infinitesimally-small change in $x$.

Let's think about this a little more. In our graph, how exactly would we compute the area of *one* of our rectangles? We can see that the height of any one of the rectangles corresponds to the value of our function $f$ and the width of the rectangle depends on how many there are. Since we've already stated that we want an infinitesimal number of rectangles, their widths are represented as $\mathrm{d}x$, some infinitesimally small value of $Δx$. So, $f(x) \mathrm{d}x$ is literally the height multiplied by the width. Note that this interpreation of $\mathrm{d}x$ is the same as in derivatives. The derivative $\frac{df}{dx}$ is measuring some infinitesimally small change in $f$ (the rise) over some infinitesimally small change in $x$ (the run).
"""

# ╔═╡ b76a1810-1de2-11eb-2edc-2d9b7de9c01e
begin
	gr()
	plot(-2:0.1:2, x -> sin(x), legend=false)
	bar!(0+0.5/2:0.5:2+0.5/2, [sin(x) for x in 0:0.5:2], bar_width=0.5, alpha=0.5, xlims=(-2,2.2), framestyle=:origin, fill=(0, 0.25, :green))
	annotate!(0.8, 0.4, L"f(x)", :red)
	plot!([1,1],[0,sin(1)], arrow=:both, c=:red)
	annotate!(1.25, -0.1, L"\mathrm{d}x", :red)
	plot!([1,1.5], [0,0], arrow=:both, c=:red)
end

# ╔═╡ 141ef252-1de9-11eb-376c-41d3acca56d4
md"""
Now that we understand integration conceptually, how do we compute an integral? First, we need to make a distinction that we've not yet made. In the world of integrals there exist *definite* integrals, which is what has been illustrated above, and *indefinite* integrals. A definite integral can be thought of as an area, as we saw above, and an indefinite integral can be thought of as a function, called an *anti-derivative.* An anti-derivative is simply a function that, when differentiated, yields the function over which we are integrating.

Take, for example, the function we worked with in the derivatives section:

$f(x) = -x^{2} + 2$

The anti-derivative, or indefinite integral, of this function is simply any function that, when differentiated, would yield $f$. One example would be

$F(x) = -\frac{1}{3}x^{3} + 2x$

We haven't explored any of the [rules for differentiation](https://www.mathsisfun.com/calculus/derivatives-rules.html) in this notebook (you can memorize those later) but, using the power rule for differentiating $F$ yields the function $f$, its derivative. In other words, $F'(x) = f(x) = -x^{2} + 2$. Note, however, that the possibilities for anti-derivatives are endless due to the fact that constants are ignored when differentiating (after all, they just shift the function up or down but don't change its slope). So, a valid $F(x)$ in this case could also be

$F(x) = -\frac{1}{3}x^{3} + 2x + 3$

Now that we have an indefinite integral for our function $f(x)$, computing the following integral is very simple:

$\int_0^2 \! f(x) \, \mathrm{d}x = F(2) - F(0) = \frac{4}{3}$

To recap, $F'(x) = f(x)$ and $\int_a^b \! f(x) \, \mathrm{d}x = F(b) - F(a)$, which actually represents **the fundamental theorem of calculus.** It shows that the process of integration is the inverse of differentiation: the derivative of $F(x)$ equals the integrand $f(x)$ and taking the difference of our anti-derivative $F$ evaluated at $a$ and $b$ yields the integral $\int_a^b \! f(x) \, \mathrm{d}x$. What's incredible about this is that we can compute the entire area under a curve by simply evaluating an antiderivative at the beginning and ending points of the interval (rather than summing the areas of an infinitesimal number of rectangles 😄).
"""

# ╔═╡ Cell order:
# ╟─00becd22-19ed-11eb-1be5-a1380e1f3e51
# ╟─c2ad8940-1a0a-11eb-38de-7d2feb4c0fba
# ╟─41505bfe-1a0b-11eb-2f7c-592c4b5aa816
# ╟─f737c88e-1a0c-11eb-1b2e-95d746db7001
# ╟─3c3f4040-1a0c-11eb-24d6-47e1ede493be
# ╟─c37f9460-1a0c-11eb-118b-eff09c826386
# ╟─14db6c30-1a12-11eb-2f49-57902f4201ce
# ╟─d92116ce-1a12-11eb-1cc5-93ef876a4ec7
# ╟─c19c9f60-1a13-11eb-3cb2-bd2f5f1094a1
# ╟─01b77a60-1ab0-11eb-3ca3-81f2678f996f
# ╟─518885c0-1ab0-11eb-3b37-85d95934e7d0
# ╟─dcf9b250-1ab0-11eb-2eb2-d5edd2ac615f
# ╟─424e5910-1ad1-11eb-14b6-a11fc2174312
# ╟─000e7392-1ad7-11eb-3d1f-0f0e6e2d65b0
# ╟─87683a90-1ac0-11eb-1386-81a04204732d
# ╟─d0233c20-1bb6-11eb-275c-ada04f429863
# ╟─db9e13e0-1bb6-11eb-34f5-ef1489135b5c
# ╟─e8837820-1bb6-11eb-1fd2-db9fa55aa429
# ╟─61c3a1d2-1bba-11eb-1b47-51d874ac5c93
# ╟─4f677ace-1bbe-11eb-24e3-8fe0c488a721
# ╟─0c72cd50-1d0e-11eb-10ac-a7639ab2c207
# ╟─188c1280-1d0f-11eb-0769-83cbdbd0fc35
# ╟─3494aa90-1ca2-11eb-39d1-bbeb7de9a2b0
# ╟─d3c490d0-1c9d-11eb-3384-5103402ef11e
# ╟─648e6200-1d64-11eb-009c-fb526f61ad14
# ╟─b76a1810-1de2-11eb-2edc-2d9b7de9c01e
# ╟─141ef252-1de9-11eb-376c-41d3acca56d4
