<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Board.BoardVO" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <%request.setCharacterEncoding("UTF-8"); %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행 이야기 목록</title>
    <style>
        :root {
            --main-color: #4CAF50;
            --secondary-color: #8BC34A;
            --accent-color: #FFC107;
            --text-color: #333;
            --light-bg: #f9f9f9;
            --border-radius: 12px;
            --box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }

        body {
            background-color: var(--light-bg);
            background-image: url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            min-height: 100vh;
        }

        .content {
            margin: 30px auto;
            padding: 40px;
            width: 90%;
            max-width: 1200px;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            backdrop-filter: blur(10px);
        }

        .mainTitle {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--main-color);
            margin-bottom: 40px;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .searchArea {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            position: relative;
        }

        .searchForm {
            display: flex;
            align-items: center;
            gap: 15px;
            width: 100%;
            max-width: 1200px;
            position: relative;
        }

        .searchType {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }

        .searchType label {
            display: flex;
            align-items: center;
            gap: 5px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 15px;
            background-color: #f8f9fa;
            transition: var(--transition);
        }

        .searchType input[type="radio"] {
            display: none;
        }

        .searchType input[type="radio"]:checked + label {
            background-color: var(--main-color);
            color: white;
        }

        .categorySelect {
            width: 240px;
            padding: 15px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 30px;
            font-size: 1.1rem;
            transition: var(--transition);
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            display: block;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 15px;
            padding-right: 40px;
        }

        .categorySelect:focus {
            outline: none;
            border-color: var(--main-color);
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        .searchInput {
            flex: 1;
            padding: 15px 20px;
            padding-left: 50px;
            border: 2px solid #e0e0e0;
            border-radius: 30px;
            font-size: 1.1rem;
            transition: var(--transition);
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: relative;
            min-width: 400px;
            width: 100%;
        }

        .searchInput:focus {
            outline: none;
            border-color: var(--main-color);
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        .searchIcon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            width: 20px;
            height: 20px;
            fill: #6c757d;
            pointer-events: none;
            z-index: 1;
        }

        .searchBtn {
            padding: 15px 30px;
            background-color: var(--main-color);
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            white-space: nowrap;
            min-width: 120px;
            justify-content: center;
        }

        .searchBtn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .searchBtnIcon {
            width: 20px;
            height: 20px;
            fill: currentColor;
        }

        .writeBtn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 15px 30px;
            background-color: var(--main-color);
            color: white;
            text-decoration: none;
            border-radius: 30px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: var(--transition);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .writeBtn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .writeIcon {
            width: 20px;
            height: 20px;
            fill: currentColor;
        }

        .boardGrid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .boardCard {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .boardCard:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .cardHeader {
            position: relative;
            height: 200px;
            overflow: hidden;
        }

        .cardImage {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .boardCard:hover .cardImage {
            transform: scale(1.05);
        }

        .cardTitle {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 20px;
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
            color: white;
            font-size: 1.2rem;
            font-weight: 600;
            text-decoration: none;
            display: block;
        }

        .cardTitle:hover {
            text-decoration: underline;
        }

        .cardAuthor {
            position: absolute;
            top: 15px;
            left: 15px;
            background-color: rgba(0,0,0,0.6);
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .authorIcon {
            width: 14px;
            height: 14px;
            fill: currentColor;
        }

        .cardContent {
            padding: 15px;
        }

        .cardMeta {
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
            color: #6c757d;
            margin-top: 10px;
        }

        .cardCategory {
            position: absolute;
            top: 15px;
            right: 15px;
            color: var(--text-color);
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
            border: 1px solid;
            background-color: white;
        }

        .categoryIcon {
            width: 14px;
            height: 14px;
            fill: currentColor;
        }

        /* 카테고리별 스타일 */
        .category_국내여행 {
            border-color: #4CAF50;
            color: #4CAF50;
        }

        .category_해외여행 {
            border-color: #2196F3;
            color: #2196F3;
        }

        .category_맛집 {
            border-color: #F44336;
            color: #F44336;
        }

        .category_숙소 {
            border-color: #9C27B0;
            color: #9C27B0;
        }

        .category_기타 {
            border-color: #607D8B;
            color: #607D8B;
        }

        .cardInfo {
            display: flex;
            flex-direction: column;
            gap: 8px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            margin-top: 10px;
        }

        .infoItem {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            color: #495057;
        }

        .infoIcon {
            width: 16px;
            height: 16px;
            fill: #6c757d;
        }

        .metaItem {
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 5px 10px;
            background-color: #f8f9fa;
            border-radius: 15px;
            transition: var(--transition);
        }

        .metaItem:hover {
            background-color: #f1f8e9;
            transform: translateY(-2px);
        }

        .budgetItem {
            background-color: #fff3cd;
            color: #856404;
        }

        .budgetItem:hover {
            background-color: #ffeeba;
        }

        .metaIcon {
            width: 16px;
            height: 16px;
            fill: currentColor;
        }

        .card_budget {
            font-size: 0.9rem;
            color: #666;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 예산 범위별 색상 스타일 */
        .budget_low {
            background-color: #d4edda;
            color: #155724;
        }

        .budget_low:hover {
            background-color: #c3e6cb;
        }

        .budget_medium {
            background-color: #cce5ff;
            color: #004085;
        }

        .budget_medium:hover {
            background-color: #b8daff;
        }

        .budget_high {
            background-color: #fff3cd;
            color: #856404;
        }

        .budget_high:hover {
            background-color: #ffeeba;
        }

        .budget_very_high {
            background-color: #f8d7da;
            color: #721c24;
        }

        .budget_very_high:hover {
            background-color: #f5c6cb;
        }

        .budget_icon {
            font-size: 1rem;
            margin-right: 3px;
        }

        @media (max-width: 768px) {
            .content {
                width: 95%;
                padding: 20px;
            }

            .mainTitle {
                font-size: 2rem;
            }

            .boardGrid {
                grid-template-columns: 1fr;
            }

            .searchForm {
                flex-direction: column;
                gap: 15px;
            }

            .categorySelect {
                width: 100%;
            }

            .searchInput {
                width: 100%;
                min-width: auto;
            }

            .searchBtn {
                width: 100%;
            }

            .writeBtn {
                width: 100%;
                justify-content: center;
                padding: 12px 20px;
                font-size: 1rem;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>

<body>
<%
    List<BoardVO> list = (List<BoardVO>) request.getAttribute("list");
%>
    <div class="content">
        <span class="mainTitle">여행 이야기 목록</span>

        <div class="searchArea">
            <form action="list.co" method="get" class="searchForm">
                <select name="category" class="categorySelect">
                    <option value="">전체 카테고리</option>
                    <option value="국내여행" <%=request.getParameter("category") != null && request.getParameter("category").equals("국내여행") ? "selected" : ""%>>국내여행</option>
                    <option value="해외여행" <%=request.getParameter("category") != null && request.getParameter("category").equals("해외여행") ? "selected" : ""%>>해외여행</option>
                    <option value="맛집" <%=request.getParameter("category") != null && request.getParameter("category").equals("맛집") ? "selected" : ""%>>맛집</option>
                    <option value="숙소" <%=request.getParameter("category") != null && request.getParameter("category").equals("숙소") ? "selected" : ""%>>숙소</option>
                    <option value="기타" <%=request.getParameter("category") != null && request.getParameter("category").equals("기타") ? "selected" : ""%>>기타</option>
                </select>
                <div style="position: relative; flex: 1;">
                    <svg class="searchIcon" viewBox="0 0 24 24">
                        <path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
                    </svg>
                    <input type="text" name="keyword" class="searchInput" placeholder="여행 이야기를 검색해보세요..." value="<%=request.getParameter("keyword") != null ? request.getParameter("keyword") : ""%>">
                </div>
                <button type="submit" class="searchBtn">
                    <svg class="searchBtnIcon" viewBox="0 0 24 24">
                        <path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
                    </svg>
                    검색
                </button>
            </form>
        </div>

        <a href="write.co" class="writeBtn">
            <svg class="writeIcon" viewBox="0 0 24 24">
                <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/>
            </svg>
            글 작성
        </a>

        <div class="boardGrid">
            <%
                if (list != null && !list.isEmpty()) {
                    for (BoardVO vo : list) {
            %>
            <div class="boardCard">
                <div class="cardHeader">
                    <%
                        String[] images = {
                            "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
                            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
                            "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
                            "https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
                            "https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
                        };
                        String randomImage = images[(int)(Math.random() * images.length)];
                    %>
                    <img src="<%=randomImage%>" alt="여행 이미지" class="cardImage">
                    <div class="cardAuthor">
                        <svg class="authorIcon" viewBox="0 0 24 24">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                        </svg>
                        <%=vo.getInstUser()%>
                    </div>
                    <div class="cardCategory category_<%=vo.getBoardCategory()%>">
                        <svg class="categoryIcon" viewBox="0 0 24 24">
                            <%
                                String iconPath = "";
                                switch(vo.getBoardCategory()) {
                                    case "국내여행":
                                        iconPath = "M14 6l-3.75 5 2.85 3.8-1.6 1.2C9.81 13.75 7 10 7 10l-6 8h22L14 6z";
                                        break;
                                    case "해외여행":
                                        iconPath = "M12 2L4.5 20.29l.71.71L12 18l6.79 3 .71-.71z";
                                        break;
                                    case "맛집":
                                        iconPath = "M8.1 13.34l2.83-2.83L3.91 3.5c-1.56 1.56-1.56 4.09 0 5.66l4.19 4.18zm6.78-1.81c1.53.71 3.68.21 5.27-1.38 1.91-1.91 2.28-4.65.81-6.12-1.46-1.46-4.2-1.1-6.12.81-1.59 1.59-2.09 3.74-1.38 5.27L3.7 19.87l1.41 1.41L12 14.41l6.88 6.88 1.41-1.41L13.41 13l1.47-1.47z";
                                        break;
                                    case "숙소":
                                        iconPath = "M15 11V5l-3-3-3 3v2H3v14h18V11h-6zm-8 8H5v-2h2v2zm0-4H5v-2h2v2zm0-4H5V9h2v2zm6 8h-2v-2h2v2zm0-4h-2v-2h2v2zm0-4h-2V9h2v2zm0-4h-2V5h2v2zm6 12h-2v-2h2v2zm0-4h-2v-2h2v2z";
                                        break;
                                    default:
                                        iconPath = "M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v6h-2zm0 8h2v2h-2z";
                                }
                            %>
                            <path d="<%=iconPath%>"/>
                        </svg>
                        <%=vo.getBoardCategory()%>
                    </div>
                    <a href="detail.co?board_idx=<%=vo.getBoardIdx()%>" class="cardTitle">
                        <%=vo.getBoardTitle()%>
                    </a>
                </div>
                <div class="cardContent">
                    <div class="cardMeta">
                        <div class="metaItem">
                            <svg class="metaIcon" viewBox="0 0 24 24">
                                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm.31-8.86c-1.77-.45-2.34-.94-2.34-1.67 0-.84.79-1.43 2.1-1.43 1.38 0 1.9.66 1.94 1.64h1.71c-.05-1.34-.87-2.57-2.49-2.97V5H10.9v1.69c-1.51.32-2.72 1.3-2.72 2.81 0 1.79 1.49 2.69 3.66 3.21 1.95.46 2.34 1.15 2.34 1.87 0 .53-.39 1.39-2.1 1.39-1.6 0-2.23-.72-2.32-1.64H8.04c.1 1.7 1.36 2.66 2.86 2.97V19h2.34v-1.67c1.52-.29 2.72-1.16 2.73-2.77-.01-2.2-1.9-2.96-3.66-3.42z"/>
                            </svg>
                            <%=vo.getViewCount()%>
                        </div>
                        <div class="metaItem">
                            <svg class="metaIcon" viewBox="0 0 24 24">
                                <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                            </svg>
                            <%=vo.getLikeCount()%>
                        </div>
                        <div class="metaItem budgetItem <%=vo.getTravelBudget() <= 100000 ? "budget_low" : 
                            (vo.getTravelBudget() <= 500000 ? "budget_medium" : 
                            (vo.getTravelBudget() <= 2000000 ? "budget_high" : "budget_very_high"))%>">
                            <svg class="metaIcon" viewBox="0 0 24 24">
                                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm.31-8.86c-1.77-.45-2.34-.94-2.34-1.67 0-.84.79-1.43 2.1-1.43 1.38 0 1.9.66 1.94 1.64h1.71c-.05-1.34-.87-2.57-2.49-2.97V5H10.9v1.69c-1.51.32-2.72 1.3-2.72 2.81 0 1.79 1.49 2.69 3.66 3.21 1.95.46 2.34 1.15 2.34 1.87 0 .53-.39 1.39-2.1 1.39-1.6 0-2.23-.72-2.32-1.64H8.04c.1 1.7 1.36 2.66 2.86 2.97V19h2.34v-1.67c1.52-.29 2.72-1.16 2.73-2.77-.01-2.2-1.9-2.96-3.66-3.42z"/>
                            </svg>
                            <div class="card_budget">
                                <span class="budget_icon">💰</span>
                                <%
                                    int budget = vo.getTravelBudget();
                                    String budgetRange;
                                    if (budget <= 100000) {
                                        budgetRange = "10만원 이하";
                                    } else if (budget <= 300000) {
                                        budgetRange = "10만원 ~ 30만원";
                                    } else if (budget <= 500000) {
                                        budgetRange = "30만원 ~ 50만원";
                                    } else if (budget <= 1000000) {
                                        budgetRange = "50만원 ~ 100만원";
                                    } else if (budget <= 2000000) {
                                        budgetRange = "100만원 ~ 200만원";
                                    } else if (budget <= 3000000) {
                                        budgetRange = "200만원 ~ 300만원";
                                    } else if (budget <= 5000000) {
                                        budgetRange = "300만원 ~ 500만원";
                                    } else if (budget <= 10000000) {
                                        budgetRange = "500만원 ~ 1000만원";
                                    } else if (budget <= 20000000) {
                                        budgetRange = "1000만원 ~ 2000만원";
                                    } else if (budget <= 30000000) {
                                        budgetRange = "2000만원 ~ 3000만원";
                                    } else if (budget <= 50000000) {
                                        budgetRange = "3000만원 ~ 5000만원";
                                    } else {
                                        budgetRange = "5000만원 이상";
                                    }
                                    out.print(budgetRange);
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="noData">등록된 게시글이 없습니다.</div>
            <%
                }
            %>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const categorySelect = document.querySelector('.categorySelect');
            const searchInput = document.querySelector('.searchInput');
            
            // 카테고리 선택 시 자동 검색
            categorySelect.addEventListener('change', function() {
                this.form.submit();
            });
        });
    </script>
</body>
</html>