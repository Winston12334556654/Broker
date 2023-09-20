<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Calendar</title>
    <style>
        /* Paste the CSS code from the previous response here */
        .calendar {
            width: 300px;
            border: 1px solid #ccc;
            margin: 0 auto;
            font-family: Arial, sans-serif;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #f0f0f0;
        }

        .days {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;

            font-weight: bold;
        }

        .day {
            flex: 1;
            text-align: center;
            padding: 5px 0;
        }

        .cells {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 2px;
            padding: 5px;
            background-color: #fff;
        }

        .cell {
            display: flex;
            align-items: center;
            justify-content: center; /* Center the content horizontally */
            height: 30px; /* Adjust the height as needed */
        }
        /* Add this CSS to your existing styles */
        .today {
            background-color: #f0f0f0;
            border-radius: 50%;
        }
        .active-date {
            background-color: #007bff; /* Change the background color to your preferred color */
            color: white;
            border-radius: 50%;
        }
    </style>
</head>
<body>
<div class="calendar">
    <div class="header">
        <button id="prevMonth">&lt;</button>
        <h2 id="currentMonth">Month Year</h2>
        <button id="nextMonth">&gt;</button>
    </div>
    <div class="days">
        <div class="day">Sun</div>
        <div class="day">Mon</div>
        <div class="day">Tue</div>
        <div class="day">Wed</div>
        <div class="day">Thu</div>
        <div class="day">Fri</div>
        <div class="day">Sat</div>
    </div>
    <div class="cells" id="calendarCells"></div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

    const prevMonthButton = document.getElementById("prevMonth");
    const nextMonthButton = document.getElementById("nextMonth");
    const currentMonthLabel = document.getElementById("currentMonth");
    const calendarCells = document.getElementById("calendarCells");

    let currentDate = new Date();
    let activeDate = null; // Store the active date

    function setActiveDate(year, month, day) {
        activeDate = new Date(year, month, day);
    }

    function renderCalendar(year, month) {
        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const daysInMonth = lastDay.getDate();

        currentMonthLabel.textContent = firstDay.toLocaleString("default", {
            month: "long",
        }) + " " + year;

        const startDate = new Date(year, month, 1 - firstDay.getDay());

        calendarCells.innerHTML = "";

        for (let i = 0; i < daysInMonth + startDate.getDay(); i++) {
            const cell = document.createElement("div");
            cell.classList.add("cell");
            if (i >= startDate.getDay()) {
                cell.textContent = startDate.getDate();
                if (
                    startDate.getDate() === currentDate.getDate() &&
                    startDate.getMonth() === currentDate.getMonth() &&
                    startDate.getFullYear() === currentDate.getFullYear()
                ) {
                    cell.classList.add("today");
                }
                if (activeDate &&
                    startDate.getDate() === activeDate.getDate() &&
                    startDate.getMonth() === activeDate.getMonth() &&
                    startDate.getFullYear() === activeDate.getFullYear()
                ) {
                    cell.classList.add("active-date");
                }
                startDate.setDate(startDate.getDate() + 1);
            }
            calendarCells.appendChild(cell);
        }
    }

    // ...

    // Set the active date
    setActiveDate(2023, 7, 28); // Year, month (0-based), day

    // Render the initial calendar
    renderCalendar(currentDate.getFullYear(), currentDate.getMonth());

    prevMonthButton.addEventListener("click", () => {
        currentDate.setMonth(currentDate.getMonth() - 1);
        renderCalendar(currentDate.getFullYear(), currentDate.getMonth());
    });

    nextMonthButton.addEventListener("click", () => {
        currentDate.setMonth(currentDate.getMonth() + 1);
        renderCalendar(currentDate.getFullYear(), currentDate.getMonth());
    });
</script>
</body>
</html>
