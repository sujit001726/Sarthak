package sarthak.dao;

import sarthak.model.SearchQuery;
import sarthak.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SearchQueryDAO {

    public boolean insertSearchQuery(SearchQuery searchQuery) {
        String sql = "INSERT INTO search_queries (user_id, query_text, filters, result_count) VALUES (?, ?, ?, ?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            setNullableInt(stmt, 1, searchQuery.getUserId());
            stmt.setString(2, searchQuery.getQueryText());
            stmt.setString(3, searchQuery.getFilters());
            stmt.setInt(4, searchQuery.getResultCount());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<SearchQuery> getSearchQueriesByUser(int userId) {
        List<SearchQuery> searchQueries = new ArrayList<>();
        String sql = "SELECT * FROM search_queries WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    searchQueries.add(mapResultSetToSearchQuery(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return searchQueries;
    }

    public List<SearchQuery> getRecentSearchQueries(int limit) {
        List<SearchQuery> searchQueries = new ArrayList<>();
        String sql = "SELECT * FROM search_queries ORDER BY created_at DESC LIMIT ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    searchQueries.add(mapResultSetToSearchQuery(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return searchQueries;
    }

    private SearchQuery mapResultSetToSearchQuery(ResultSet rs) throws SQLException {
        SearchQuery searchQuery = new SearchQuery();
        searchQuery.setId(rs.getInt("id"));
        int userId = rs.getInt("user_id");
        searchQuery.setUserId(rs.wasNull() ? null : userId);
        searchQuery.setQueryText(rs.getString("query_text"));
        searchQuery.setFilters(rs.getString("filters"));
        searchQuery.setResultCount(rs.getInt("result_count"));
        searchQuery.setCreatedAt(rs.getTimestamp("created_at"));
        return searchQuery;
    }

    private void setNullableInt(PreparedStatement stmt, int index, Integer value) throws SQLException {
        if (value == null) {
            stmt.setNull(index, Types.INTEGER);
        } else {
            stmt.setInt(index, value);
        }
    }
}
