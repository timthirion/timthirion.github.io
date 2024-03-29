---
layout: post
title:  "Welcome to Jekyll!"
date:   2022-03-18 16:41:18 -0400
usemathjax: true
---
You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

Jekyll requires blog post files to be named according to the following format:

`YEAR-MONTH-DAY-title.MARKUP`

Where `YEAR` is a four-digit number, `MONTH` and `DAY` are both two-digit numbers, and `MARKUP` is the file extension representing the format used in the file. After that, include the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

Here's some rust code:

{% highlight rust %}
macro_rules! blow_up {
  ($a:ident) => {
    println!("hello {}!", stringify!($a));
  };

  ($a:ident $($rest:tt)+) => {
      blow_up!($a);
      blow_up!($($rest)+);
      blow_up!($($rest)+);
  }
}

macro_rules! make_slow {
  () => {
      blow_up!(
          a0 b0 c0 d0 e0 f0 g0 h0 i0 j0
      );
  }
}
{% endhighlight %}

{% highlight c++ %}
std::vector<float> average(const std::vector<float> &scalars) {
  float average = 0.0f;
  for (int i = 0; i < scalars.size(); ++i) {
    average += scalars[i];
  }
  return average / scalars.count();
}
{% endhighlight %}

$$E=mc^2$$

$$\int_{0}^{1}f(x)dx$$

Sometimes math can be inline too, such as $$x=3$$. This is the next sentence.

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
