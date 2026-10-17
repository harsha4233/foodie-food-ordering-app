
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.Locale" %>

<%
    String orderStatus = (String) request.getAttribute("orderStatus");

    if (orderStatus == null || orderStatus.trim().isEmpty()) {
        orderStatus = "PLACED";
    }

    orderStatus = orderStatus.toUpperCase(Locale.ROOT);

    int currentStep = 1;

    if ("PREPARING".equals(orderStatus)) {
        currentStep = 2;
    } else if ("OUT_FOR_DELIVERY".equals(orderStatus)) {
        currentStep = 3;
    } else if ("DELIVERED".equals(orderStatus)) {
        currentStep = 4;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Order Successful | Foodie</title>

<style>
:root {
    --orange: #ff7200;
    --gold: #ffb900;
    --white: #ffffff;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html,
body {
    width: 100%;
    height: 100%;
    margin: 0;
    overflow: hidden;
}

body {
    position: relative;
    background: #170803;
    color: var(--white);
    font-family: "Segoe UI", Arial, sans-serif;
}

/* FULL-SCREEN VIDEO BACKGROUND */

.background-video {
    position: fixed;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center center;
    z-index: 0;
    background: #170803;
}

/* Gradient overlay preserves video visibility */

.video-overlay {
    position: fixed;
    inset: 0;
    z-index: 1;
    pointer-events: none;

    background: linear-gradient(
        90deg,
        rgba(15, 5, 0, 0.82) 0%,
        rgba(15, 5, 0, 0.62) 32%,
        rgba(15, 5, 0, 0.20) 65%,
        rgba(15, 5, 0, 0.12) 100%
    );
}

/* TOP-CENTER FOODIE BRAND */

.brand {
    position: fixed;
    top: 14px;
    left: 50%;
    transform: translateX(-50%);
    z-index: 4;

    display: flex;
    align-items: center;
    gap: 9px;

    white-space: nowrap;
    font-size: clamp(25px, 2.7vw, 35px);
    font-weight: 900;
    letter-spacing: -1px;

    text-shadow: 0 3px 15px #000;
}

.brand-icon {
    font-size: 28px;
}

.brand-food {
    color: white;
}

.brand-ie {
    color: var(--gold);
}

/* MAIN PAGE: ONE SCREEN */

.page {
    position: relative;
    z-index: 2;

    width: 100%;
    height: 100vh;
    height: 100dvh;

    padding: 70px 5% 12px;

    display: flex;
    align-items: center;

    overflow: hidden;
}

.success-content {
    width: min(550px, 48vw);
    max-height: 100%;
    overflow: visible;

    animation: slideIn 0.7s ease-out both;
}

/* SUCCESS LABEL */

.eyebrow {
    display: inline-flex;
    align-items: center;
    gap: 8px;

    margin-bottom: 13px;
    padding: 7px 12px;

    border: 1px solid rgba(255, 185, 0, 0.45);
    border-radius: 25px;

    background: rgba(35, 14, 3, 0.55);
    color: #ffe5ae;

    font-size: 11px;
    font-weight: 800;
    letter-spacing: 1.5px;
}

.eyebrow-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #58ef94;
    box-shadow: 0 0 10px #58ef94;
}

/* MAIN HEADING */

.success-title {
    font-size: clamp(38px, 4.6vw, 66px);
    font-weight: 950;
    line-height: 0.99;
    letter-spacing: -1.7px;

    text-shadow: 0 5px 20px rgba(0, 0, 0, 0.65);
}

.success-title span {
    display: block;
    margin-top: 5px;
    color: var(--gold);
}

.tagline {
    margin-top: 11px;

    color: rgba(255, 255, 255, 0.95);
    font-size: clamp(14px, 1.5vw, 18px);
    line-height: 1.5;
}

/* SUCCESS CHECK AND THANK-YOU MESSAGE */

.check-row {
    display: flex;
    align-items: center;
    gap: 13px;
    margin-top: 15px;
}

.success-check {
    flex-shrink: 0;

    width: 53px;
    height: 53px;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 50%;
    border: 2px solid rgba(255, 255, 255, 0.9);

    background: linear-gradient(145deg, #ffb52c, #ff6500);

    box-shadow:
        0 0 0 6px rgba(255, 129, 0, 0.13),
        0 0 27px rgba(255, 112, 0, 0.48);

    font-size: 32px;
    font-weight: 900;

    animation: checkPop 0.65s 0.2s both;
}

.thank-you h2 {
    font-size: clamp(13px, 1.5vw, 18px);
    line-height: 1.4;
    font-weight: 850;
}

.thank-you p {
    margin-top: 5px;
    color: var(--gold);
    font-size: 13px;
    font-weight: 750;
}

/* ORDER TRACKER */

.order-tracker {
    width: 100%;
    margin-top: 19px;
    padding: 14px 15px;

    border: 1px solid rgba(255, 255, 255, 0.23);
    border-radius: 17px;

    background: rgba(22, 10, 4, 0.48);

    backdrop-filter: blur(9px);
    -webkit-backdrop-filter: blur(9px);

    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
}

.tracker-heading {
    display: flex;
    align-items: center;
    gap: 9px;

    margin-bottom: 15px;
    font-size: 14px;
    font-weight: 800;
}

.tracker-heading span {
    font-size: 19px;
}

.tracker-steps {
    position: relative;

    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 3px;
}

.tracker-line {
    position: absolute;
    top: 14px;
    left: 12.5%;
    right: 12.5%;
    height: 3px;

    background: rgba(255, 255, 255, 0.30);
    z-index: 0;
}

.tracker-progress {
    position: absolute;
    top: 14px;
    left: 12.5%;
    height: 3px;

    width: <%= ((currentStep - 1) * 25) %>%;

    background: linear-gradient(90deg, #ffb52c, #ff7100);
    box-shadow: 0 0 8px rgba(255, 132, 0, 0.7);
    z-index: 1;
}

.tracker-step {
    position: relative;
    z-index: 2;

    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    min-width: 0;
}

.step-circle {
    width: 30px;
    height: 30px;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 50%;
    border: 2px solid rgba(255, 255, 255, 0.85);

    background: rgba(22, 10, 4, 0.96);
    color: white;
    font-size: 13px;
}

.tracker-step.done .step-circle {
    background: linear-gradient(145deg, #ffb52c, #ff7200);
    border-color: #ffcb66;
    box-shadow: 0 0 12px rgba(255, 137, 0, 0.4);
}

.tracker-step.active .step-circle {
    border-color: var(--gold);
    box-shadow: 0 0 0 4px rgba(255, 189, 46, 0.12);
}

.step-label {
    margin-top: 7px;
    font-size: 10px;
    line-height: 1.3;
    color: rgba(255, 255, 255, 0.9);
}

.tracker-step.active .step-label {
    color: var(--gold);
    font-weight: 800;
}

/* HOME BUTTON */

.home-button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;

    margin-top: 15px;
    padding: 11px 19px;

    border: 1px solid rgba(255, 255, 255, 0.75);
    border-radius: 35px;

    background: linear-gradient(100deg, #ffb000, #ff6400);
    color: white;

    font-size: 13px;
    font-weight: 800;
    text-decoration: none;

    box-shadow: 0 8px 22px rgba(255, 103, 0, 0.25);
    transition: transform 0.25s, box-shadow 0.25s;
}

.home-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 28px rgba(255, 103, 0, 0.48);
}

/* CONFETTI */

#confetti {
    position: fixed;
    inset: 0;
    width: 100%;
    height: 100%;
    z-index: 5;
    pointer-events: none;
}

/* ANIMATIONS */

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(18px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes checkPop {
    0% {
        opacity: 0;
        transform: scale(0.35) rotate(-25deg);
    }
    75% {
        transform: scale(1.1) rotate(5deg);
    }
    100% {
        opacity: 1;
        transform: scale(1) rotate(0);
    }
}

/* SHORT DESKTOP SCREENS */

@media (max-height: 700px) {
    .page {
        padding-top: 58px;
        padding-bottom: 8px;
    }

    .eyebrow {
        margin-bottom: 8px;
        padding: 6px 10px;
        font-size: 10px;
    }

    .success-title {
        font-size: clamp(30px, 3.8vw, 49px);
    }

    .tagline {
        margin-top: 7px;
        font-size: 14px;
    }

    .check-row {
        margin-top: 9px;
    }

    .success-check {
        width: 44px;
        height: 44px;
        font-size: 27px;
    }

    .order-tracker {
        margin-top: 11px;
        padding: 9px 12px;
    }

    .tracker-heading {
        margin-bottom: 9px;
    }

    .home-button {
        margin-top: 9px;
    }
}

/* MOBILE */

@media (max-width: 768px) {
    .background-video {
        object-position: 60% center;
    }

    .video-overlay {
        background: rgba(15, 5, 0, 0.62);
    }

    .brand {
        top: 12px;
        font-size: 27px;
    }

    .page {
        padding: 65px 17px 10px;
        align-items: center;
    }

    .success-content {
        width: 100%;
    }

    .success-title {
        font-size: clamp(33px, 8.5vw, 48px);
    }

    .tagline {
        font-size: 14px;
    }

    .thank-you h2 {
        font-size: 12px;
    }

    .thank-you p {
        font-size: 11px;
    }

    .order-tracker {
        padding: 12px 8px;
    }

    .tracker-heading {
        font-size: 12px;
        margin-bottom: 12px;
    }

    .step-circle {
        width: 27px;
        height: 27px;
        font-size: 11px;
    }

    .tracker-line,
    .tracker-progress {
        top: 12px;
    }

    .step-label {
        font-size: 9px;
    }

    .home-button {
        font-size: 12px;
        padding: 10px 15px;
    }
}

@media (max-width: 380px) {
    .success-title {
        font-size: 32px;
    }

    .tracker-steps {
        gap: 0;
    }

    .step-label {
        font-size: 8px;
    }
}

@media (prefers-reduced-motion: reduce) {
    .success-content,
    .success-check {
        animation: none;
    }

    .home-button {
        transition: none;
    }
}
</style>
</head>

<body>

<!-- Full-screen background video -->
<video class="background-video"
       autoplay muted loop playsinline preload="auto"
       aria-hidden="true">
    <source
        src="<%= request.getContextPath() %>/videos/suc.mp4"
        type="video/mp4">
</video>

<!-- Overlay -->
<div class="video-overlay"></div>

<!-- Confetti -->
<canvas id="confetti"></canvas>

<!-- Top-center brand -->
<header class="brand">
    <span class="brand-icon">🍴</span>
    <span><span class="brand-food">Food</span><span class="brand-ie">ie</span></span>
</header>

<main class="page">
    <section class="success-content">

        <div class="eyebrow">
            <span class="eyebrow-dot"></span>
            ORDER PLACED SUCCESSFULLY
        </div>

        <!-- <h1 class="success-title">
            ORDER
            <span>SUCCESSFUL!</span>
        </h1> -->

        <p class="tagline">
            Your cravings are on their way.<br>
            Get ready for something delicious!
        </p>

        <div class="check-row">
            <div class="success-check">✓</div>

            <div class="thank-you">
                <h2>THANK YOU FOR ORDERING WITH FOODIE!</h2>
                <p>Your order has been confirmed!</p>
            </div>
        </div>

        <!-- Order journey tracker -->
        <section class="order-tracker">
            <h2 class="tracker-heading">
                <span>🚚</span>
                Your Order Journey
            </h2>

            <div class="tracker-steps">

                <div class="tracker-line"></div>
                <div class="tracker-progress"></div>

                <div class="tracker-step <%= currentStep >= 1 ? "done" : "" %> <%= currentStep == 1 ? "active" : "" %>">
                    <div class="step-circle"><%= currentStep >= 1 ? "✓" : "1" %></div>
                    <span class="step-label">Confirmed</span>
                </div>

                <div class="tracker-step <%= currentStep >= 2 ? "done" : "" %> <%= currentStep == 2 ? "active" : "" %>">
                    <div class="step-circle"><%= currentStep >= 2 ? "✓" : "2" %></div>
                    <span class="step-label">Preparing</span>
                </div>

                <div class="tracker-step <%= currentStep >= 3 ? "done" : "" %> <%= currentStep == 3 ? "active" : "" %>">
                    <div class="step-circle"><%= currentStep >= 3 ? "✓" : "3" %></div>
                    <span class="step-label">On the way</span>
                </div>

                <div class="tracker-step <%= currentStep >= 4 ? "done" : "" %> <%= currentStep == 4 ? "active" : "" %>">
                    <div class="step-circle"><%= currentStep >= 4 ? "✓" : "4" %></div>
                    <span class="step-label">Delivered</span>
                </div>

            </div>
        </section>

        <!-- Change /home if your application uses a different home mapping -->
        <a class="home-button"
           href="<%= request.getContextPath() %>/">
            <span>←</span>
            Back to Foodie Home
        </a>

    </section>
</main>

<script>
/* CONFETTI ANIMATION */

(function () {
    const canvas = document.getElementById("confetti");
    const ctx = canvas.getContext("2d");

    if (!ctx) return;

    let width = 0;
    let height = 0;
    let particles = [];
    let animationId;
    let running = true;

    const colors = [
        "#ffad00",
        "#ff6a00",
        "#ffffff",
        "#ffcc55",
        "#ff3d32"
    ];

    function resizeCanvas() {
        const dpr = Math.min(window.devicePixelRatio || 1, 2);

        width = window.innerWidth;
        height = window.innerHeight;

        canvas.width = width * dpr;
        canvas.height = height * dpr;

        canvas.style.width = width + "px";
        canvas.style.height = height + "px";

        ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    }

    function createParticle(initial) {
        return {
            x: Math.random() * width,
            y: initial
                ? Math.random() * height
                : -20 - Math.random() * 100,

            size: 3 + Math.random() * 4,
            speedY: 1 + Math.random() * 2.5,
            speedX: (Math.random() - 0.5) * 1.5,
            rotation: Math.random() * Math.PI,
            rotationSpeed: (Math.random() - 0.5) * 0.1,
            color: colors[Math.floor(Math.random() * colors.length)],
            opacity: 0.65 + Math.random() * 0.35
        };
    }

    function initializeParticles() {
        const count = Math.min(
            100,
            Math.max(40, Math.floor(width / 12))
        );

        particles = [];

        for (let i = 0; i < count; i++) {
            particles.push(createParticle(true));
        }
    }

    function animate() {
        if (!running) return;

        ctx.clearRect(0, 0, width, height);

        for (let i = 0; i < particles.length; i++) {
            const p = particles[i];

            ctx.save();
            ctx.translate(p.x, p.y);
            ctx.rotate(p.rotation);
            ctx.globalAlpha = p.opacity;
            ctx.fillStyle = p.color;

            ctx.fillRect(
                -p.size / 2,
                -p.size / 2,
                p.size,
                p.size * 1.5
            );

            ctx.restore();

            p.x += p.speedX + Math.sin(p.y * 0.012) * 0.4;
            p.y += p.speedY;
            p.rotation += p.rotationSpeed;

            if (p.y > height + 20) {
                particles[i] = createParticle(false);
            }

            if (p.x < -20) p.x = width + 10;
            if (p.x > width + 20) p.x = -10;
        }

        animationId = requestAnimationFrame(animate);
    }

    resizeCanvas();
    initializeParticles();

    if (!window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
        animate();
    }

    window.addEventListener("resize", function () {
        resizeCanvas();
        initializeParticles();
    });

    document.addEventListener("visibilitychange", function () {
        if (document.hidden) {
            running = false;
            cancelAnimationFrame(animationId);
        } else if (!running) {
            running = true;
            animate();
        }
    });
})();
</script>

</body>
</html>
