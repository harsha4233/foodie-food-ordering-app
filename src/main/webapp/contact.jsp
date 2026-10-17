<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Contact - Foodie</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/contact.css">

</head>

<body>

    <!-- COMMON NAVBAR -->
    <%@ include file="navbar.jsp" %>


    <main class="contact-page">

        <div class="contact-container">

            <!-- LEFT SIDE -->

            <section class="contact-info">

                <span class="small-title">
                    GET IN TOUCH
                </span>

                <h1>
                    Contact <span>Foodie</span>
                </h1>

                <p class="intro">
                    Have a question, suggestion, or found an issue?
                    We'd love to hear from you.
                </p>


                <!-- EMAIL -->

                <div class="contact-item">

                    <div class="contact-icon">
                        ✉
                    </div>

                    <div>
                        <span>Email</span>
                        <h3>
                            harshavardhan@example.com
                        </h3>
                    </div>

                </div>


                <!-- PHONE -->

                <div class="contact-item">

                    <div class="contact-icon">
                        ☎
                    </div>

                    <div>
                        <span>Phone</span>
                        <h3>
                            +91 XXXXX XXXXX
                        </h3>
                    </div>

                </div>


                <!-- LOCATION -->

                <div class="contact-item">

                    <div class="contact-icon">
                        📍
                    </div>

                    <div>
                        <span>Location</span>
                        <h3>
                            Bengaluru, India
                        </h3>
                    </div>

                </div>


                <!-- SOCIAL LINKS -->

                <div class="social-links">

                    <a href="https://github.com/harsha4233"
                       target="_blank"
                       rel="noopener noreferrer">
                        GitHub
                    </a>

                    <a href="https://www.linkedin.com/in/muppalla-harsha-vardhan"
                       target="_blank"
                       rel="noopener noreferrer">
                        LinkedIn
                    </a>

                </div>

            </section>


            <!-- RIGHT SIDE -->

            <section class="contact-form-card">

                <div class="form-heading">

                    <h2>
                        Send us a <span>Message</span>
                    </h2>

                    <p>
                        Fill out the form and we'll get back to you.
                    </p>

                </div>


                <form action="#" method="post">

                    <!-- NAME -->

                    <div class="form-group">

                        <label for="name">
                            Your Name
                        </label>

                        <input type="text"
                               id="name"
                               name="name"
                               placeholder="Enter your name"
                               required>

                    </div>


                    <!-- EMAIL -->

                    <div class="form-group">

                        <label for="email">
                            Email Address
                        </label>

                        <input type="email"
                               id="email"
                               name="email"
                               placeholder="Enter your email"
                               required>

                    </div>


                    <!-- SUBJECT -->

                    <div class="form-group">

                        <label for="subject">
                            Subject
                        </label>

                        <input type="text"
                               id="subject"
                               name="subject"
                               placeholder="What is this about?"
                               required>

                    </div>


                    <!-- MESSAGE -->

                    <div class="form-group">

                        <label for="message">
                            Message
                        </label>

                        <textarea id="message"
                                  name="message"
                                  rows="5"
                                  placeholder="Write your message..."
                                  required></textarea>

                    </div>


                    <!-- BUTTON -->

                    <button type="submit"
                            class="send-btn">

                        Send Message

                        <span>→</span>

                    </button>

                </form>

            </section>

        </div>

    </main>

</body>

</html>