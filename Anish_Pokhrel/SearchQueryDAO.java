package sarthak.dao;

import sarthak.model.SearchQuery;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.Comparator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicInteger;

public class SearchQueryDAO {
    private static final AtomicInteger NEXT_ID = new AtomicInteger(1);
    private static final List<SearchQuery> SEARCH_QUERIES = new CopyOnWriteArrayList<>();

    public boolean insertSearchQuery(SearchQuery searchQuery) {
        searchQuery.setId(NEXT_ID.getAndIncrement());
        searchQuery.setCreatedAt(Timestamp.from(Instant.now()));
        SEARCH_QUERIES.add(searchQuery);
        return true;
    }

    public List<SearchQuery> getSearchQueriesByUser(int userId) {
        return SEARCH_QUERIES.stream()
                .filter(searchQuery -> searchQuery.getUserId() != null && searchQuery.getUserId() == userId)
                .sorted(Comparator.comparing(SearchQuery::getCreatedAt).reversed())
                .toList();
    }

    public List<SearchQuery> getRecentSearchQueries(int limit) {
        return SEARCH_QUERIES.stream()
                .sorted(Comparator.comparing(SearchQuery::getCreatedAt).reversed())
                .limit(limit)
                .toList();
    }
}
