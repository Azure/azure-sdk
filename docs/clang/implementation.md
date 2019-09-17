---
title: "C Guidelines: Implementation"
keywords: guidelines clang
permalink: clang_implementation.html
folder: clang
sidebar: clang_sidebar
---

{% include draft.html content="The C Language guidelines are in DRAFT status" %}

## Supported platforms

{% include requirement/MUST id="clang-c99" %} implement the client library in [C99](https://en.wikipedia.org/wiki/C99) to ensure maximum portability of your code. While MSVC supports most C99 features, it is not fully compatible with C99 yet.  If using MSVC (or if Windows is required), ensure you avoid non-supported C99 features in MSVC.

> TODO: Provide a link to non-supported C99 features in MSVC

{% include requirement/SHOULD id="clang-platform" %} support the following platforms and associated compilers when implementing your client library.

| Operating System    | Architecture | Compiler Version                        |
|---------------------|:------------:|:----------------------------------------|
| Ubuntu 16.04 (LTS)  | x64          | gcc-5.4.0                               |
| Ubuntu 18.04 (LTS)  | x86          | gcc-7.3                                 |
| Ubuntu 18.04 (LTS)  | x64          | Clang 6.0.x                             |
| OSX 10.13.4         | x64          | XCode 9.4.1                             |
| Windows Server 2016 | x86          | MSVC 14.16.x                            |
| Windows Server 2016 | x64          | MSVC 14.16.x                            |
| Debian 9 Stretch    | x64          | gcc-7.x                                 |

> TODO: This is based on versions supported by the Azure IoT SDK for C.  Additional investigation is needed to ensure it is up to date.  We need to make sure the version supported is the latest long term servicing with wide adoption available for each platform.  Suggested additions: RHEL 8 (gcc 8.2.1) and Fedora (30 with gcc 9.1.1) + Alpine.  Windows Server 2016 includes Windows 8 - should we switch?

> TODO: provide any common flags to be used with each compiler.

{% include requirement/SHOULDNOT id="clang-cpp-extensions" %} use compiler extensions.  Examples of extensions to avoid include:

* [MSVC compiler extensions](https://docs.microsoft.com/en-us/cpp/build/reference/microsoft-extensions-to-c-and-cpp?view=vs-2019)
* [Clang language extensions](https://clang.llvm.org/docs/LanguageExtensions.html)
* [GNU C compiler extensions](https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html)

Use the appropriate options for each compiler to prevent the use of such extensions.

{% include requirement/MUST id="clang-cpp-options" %} use compiler flags to identify warnings:

| Compiler                 | Compiler Flags   |
|:-------------------------|------------------|
| gcc                      | `-Wall -Wextra`  |
| Clang and XCode          | `-Weverything`   |
| MSVC                     | `/W4`            |

## Configuration

> TODO: Implement the spirit of the general guidelines for configuration

## Parameter validation

> TODO: Implement the spirit of the general guidelines for paramter validation

## Network requests

> TODO: Implement the spirit of the general guidelines for network requests

## Authentication

> TODO: Implement the spirit of the general guidelines for authentication

## Error handling

> TODO: Implement the spirit of the general guidelines for error handling

## Logging

> TODO: Implement the spirit of the general guidelines for logging

## Distributed tracing

> TODO: Implement the spirit of the general guidelines for distributed tracing

## Dependencies

> TODO: Implement the spirit of the general guidelines for dependencies

## Testing

> TODO: Implement the spirit of the general guidelines for testing

## Coding style

### Files 

{% include requirement/MUST id="clang-style-filenaming" %} name all files as lowercase, prefixed by the service short name; separate words with underscores, and end with the appropriate extension (`.c` or `.h`).  For example, `iot_credential.c` is valid, while `IoTCredential.cl` is not.

{% include requirement/MUST id="clang-style-publicapi-hdr" %} identify the file containing the public API with `<svcname>_<objname>_api.h`.  For example, `iot_credential_api.h`.

{% include requirement/MUST id="clang-style-privateapi-hdr" %} place an include file that is not part of the public API in an `internal` directory.  Do no include the service short name.  For example, `internal/credential.h`.

{% include requirement/MUST id="clang-style-filenames" %} use characters in the range `[a-z0-9_]` for the name portion (before the file extension).  No other characters are permitted.

Filenames should be concise, but convey what role the file plays within the library.

{% include requirement/MUST id="clang-style-headerguards" %} use header file guards:
#ifndef IOT_CLIENT_H
#define IOT_CLIENT_H

/* Contents of iot_client.h */

#endif /* IOT_CLIENT_H */
{% highlight c %}

## Packaging

> TODO: Implement the mechanism by which C libraries will be packaged for distribution

## Other tools

> TODO: Implement any other tools that we feel improve the productivity of C developers

## Formatting

{% include requirement/MUST id="clang-format-clang" %} use [clang-format](http://clang.llvm.org/docs/ClangFormat.html) for formatting your code. Use the common `clang-format` options from Engineering Systems.

In general, clang-format will format your code correctly and ensure consistency. However, these are few additional  rules to keep in mind.

{% include requirement/MUST id="clang-format-clang-loops" %} place all conditional or loop statements on one line, or add braces to identify the conditional/looping block.

{% include requirement/MUST id="clang-format-clang-closing-braces" %} add comments to closing braces.  Adding a comment to closing braces can help when you are reading code because you don't have to find the begin brace to know what is going on.

{% highlight c %}
while (1) {
    if (valid) {
        ...
    } /* if valid */
    else {

    } /* not valid */
} /* end forever */
{% endhighlight %}

{% include requirement/MUST id="clang-format-clang-closing-endif" %} add comments to closing preprocessor to make it easier to understand it.  For example:

{% highlight c %}
#if _BEGIN_CODE_

#ifndef _INTERNAL_CODE_

#endif /* _INTERNAL_CODE_ */

#endif /* _BEGIN_CODE_ */
{% endhighlight %}

{% include requirement/MUST id="clang-format-clang-space-kw" %} place a space between a keyword and a following paren.


{% include requirement/MUST id="clang-format-clang-space-func" %} place parens next to function names.

{% include requirement/SHOULDNOT id="clang-format-clang-space-return" %} use parens in return statements when it isn't necessary.

{% include requirement/MUST id="clang-format-clang-ifelse" %} place each segment of an `if`/`then`/`else` statement on a separate line if you have a block.  If you include `else if` statements, ensure you also add an `else` block for finding unhandled cases.

For example:

{% highlight c %}
if (valid) {
    ...
} /* if valid */
else {

} /* not valid */
{% endhighlight %}

{% include requirement/MUST id="clang-format-clang-yoda" %} place the constant on the left hand side of an eqality/inequality comparison (yoda style).  For example, `if (6 == errNum) ...`.
~

{% include requirement/MUST id="clang-format-clang-comment-fallthru" %} include a comment for falling through a non-empty `case` statement.  For example:

{% highlight c %}
switch (...) {
    case 1:
        do_something();
        break;
    case 2:
        do_something_else();
        /* fall through */
    case 3: 
        {
            int v;

            do_something_more(v);
        }
        break;
    default:
        log(LOG_DEBUG, "default case reached");
}
{% endhighlight %}

{% include requirement/SHOULDNOT id="clang-format-clang-no-goto" %} use `goto` statements.  The main place where `goto` statements can be usefully employed is to break out of several levels of `switch`, `for`, or `while` nesting, although the need to do such a thing may indicate that the inner constructs should be broken out into a separate function with a success/failure return code.  When a `goto` is necessary, the accompanying label should be alone on a line and to the left of the code that follows.  The `goto` should be commented as to its utility and purpose.

## Complexity Management

{% include requirement/MUST id="clang-init-all-vars" %} initialize all variables. Use compiler flags (such as `gcc -Wall` or `cl.exe /W4`) to catch operations on uninitialized variables.

{% include requirement/SHOULD id="clang-function-size" %} limit function bodies to one page of code (40 lines, approximately).

{% include requirement/MUST id="clang-document-null-bodies" %} document null statements.  Always document a null body for a `for` or `while` statement so that it is clear the null body is intentional.

{% include requirement/MUST id="clang-use-explicit-compares" %} use explicit comparisons when testing for failure.  Use `if (FAIL != f())` rather than `if (f())`, even though FAIL may have the value 0 which C considers to be false.  An explicit test will help you out later when somebody decides that a failure return should be -1 instead of 0.  

Explicit comparison should be used even if the comparison value will never change.  e.g. `if (!(bufsize % sizeof(int)))` should be written as `if (0 == (bufsize % sizeof(int))` to reflect the numeric (not boolean) nature of the test.  

A frequent trouble spot is using `strcmp` to test for string equality.  You should **never** use a default action.  The preferred approach is to use an inline function:

{% highlight c %}
inline bool string_equal(char *a, char *b) {
    return (0 == strcmp(a, b));
}
{% endhighlight %}

~ Should
{% include requirement/SHOULDNOT id="clang-embedded-assign" %} use embedded assignments.  There is a time and a place for embedded assignment statements.  In some constructs, there is no better way to accomplish the results without making the code bulkier and less readable.

{% highlight c %}
while (EOF != (c = getchar())) {
    /* process the character */
}
{% endhighlight %}

However, one should consider the tradeoff between increased speed and decreased maintainability that results when embedded assignments are used in artificial places.

## Miscellaneous

{% include requirement/MUSTNOT id="clang-test-implicit-assign" %} use implicit assignment inside a test.  This is generally an accidental omission of the second `=` of the logical compare. The following is confusing and prone to error.
    
{% highlight c %}
if (a = b) { ... }
{% endhighlight %}

Does the programmer really mean assignment here? Sometimes yes, but usually no. Instead use explicit tests and avoid assignment with an implicit test. The recommended form is to do the assignment before doing the test:

{% highlight c %}
a = b;
if (a) { ... } 
{% endhighlight %}

{% include requirement/MUST id="clang-no-register" %} use the register sparingly to indicate the variables that you think are most critical.  Modern compilers will put variables in registers automatically.  In extreme cases, mark the 2-4 most critical values as `register` and mark the rest as `REGISTER`. The latter can be `#defined` to register on those machines with many registers.

{% include requirement/MUST id="clang-be-const-correct" %} be `const` correct.  C provides the `const` keyword to allow passing as parameters objects that cannot change to indicate when a method doesn't modify its object. Using `const` in all the right places is called "const correctness." 

{% include requirement/MUST id="clang-use-hashif" %} use `#if` instead of `#ifdef`.  For example:

{% highlight c %}
// Bad example
#ifdef DEBUG
    temporary_debugger_break();
#endif
{% endhighlight %}

Someone else might compile the code with turned-of debug info like:

{% highlight c %}
cc -c lurker.cc -DDEBUG=0
{% endhighlight %}

Alway use `#if` if you have to use the preprocessor. This works fine, and does the right thing, even if `DEBUG` is not defined at all (!)

{% highlight c %}
// Good example
#if DEBUG
    temporary_debugger_break();
#endif
{% endhighlight %}

If you really need to test whether a symbol is defined or not, test it with the `defined()` construct, which allows you to add more things later to the conditional without editing text that's already in the program:

{% highlight c %}
#if !defined(USER_NAME)
 #define USER_NAME "john smith"
#endif
{% endhighlight %}

{% include requirement/MUST id="clang-large-comments" %}
Use `#if` to comment out large code blocks.

Sometimes large blocks of code need to be commented out for testing.  The easiest way to do this is with an `#if 0` block:

{% highlight c %}
void example()
{
    great looking code

    #if 0
      many lines  of code
    #endif

    more code
}
{% endhighlight %}

You can't use `/**/` style comments because comments can't contain comments and a large block of your code will probably contain connects.

Do not use `#if 0` directly.  Instead, use descriptive macro names:

{% highlight c %}
#if NOT_YET_IMPLEMENTED  
#if OBSOLETE
#if TEMP_DISABLED
{% endhighlight %}

Always add a short comment explaining why it is commented out.

{% include requirement/MUSTNOT id="clang-" %} put data definitions in header files.  For example, this should be avoided:

{% highlight c %}
/* aheader.h */
int x = 0;
{% endhighlight %}

It's bad magic to have space consuming code silently inserted through the innocent use of header files.  It's not common practice to define variables in the header file, so it will not occur to developers to look for this when there are problems.  Instead, define the variable once in a source file and then use an `extern` statement to reference it in the header file.

{% include requirement/MUSTNOT id="clang-no-magic-numbers" %} use magic numbers. A magic number is a bare naked number used in source code. It's magic because no-one will know what it means after a while.  This significantly reduces maintainability. For example:

{% highlight c %}
// Don't write this.
if      (22 == foo) { start_thermo_nuclear_war(); }
else if (19 == foo) { refund_lots_money(); }
else if (16 == foo) { infinite_loop(); }
else                { cry_cause_im_lost(); }
{% endhighlight %}

Instead of magic numbers, use a real name that means something. You can use `#define`, constants, or enums as names. For example:

{% highlight c %}
// These are good ideas.
#define   PRESIDENT_WENT_CRAZY  (22)
const int WE_GOOFED= 19;
enum  {
   THEY_DIDNT_PAY= 16
};

if      (PRESIDENT_WENT_CRAZY == foo) { start_thermo_nuclear_war(); }
else if (WE_GOOFED            == foo) { refund_lots_money(); }
else if (THEY_DIDNT_PAY       == foo) { infinite_loop(); }
else                                  { happy_days_i_know_why_im_here(); }
{% endhighlight %}

Prefer `enum` values since the debugger can display the label and value and no memory is allocated.  If you use `const`, memory is allocated.  If you use `#define`, the debugger cannot display the label.

{% include requirement/MUST id="clang-check-syscall-errors" %} check every system call for an error return, unless you know you wish to ignore errors. For example, `printf` returns an error code but it is rarely relevant. Cast the return to (void) if you do not care about the error code.

{% highlight c %}
(void)printf("The return type is ignored");
{% endhighlight %}
~

{% include requirement/MUST id="clang-include-errorstr" %} include the system error text when reporting system error messages.

{% include requirement/MUST id="clang-check-malloc" %} check every call to `malloc` or `realloc`. 

We recommend that you use a library-specific wrapper for memory allocation calls that always do the right thing.
